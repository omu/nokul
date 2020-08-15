# frozen_string_literal: true

module Actions
  module User
    module Verification
      class Result
        attr_reader :result, :errors, :status

        def initialize
          @status = false
          @errors = ActiveModel::Errors.new(self)
        end

        def succeeded(result = nil)
          self.result = result
          self.status = true
          self
        end

        def accordingly
          raise ArgumentError, 'Block required' unless block_given?

          case (result = yield)
          when TrueClass, FalseClass, NilClass
            self.status = !!result # rubocop:disable Style/DoubleNegation
          else
            succeeded(result)
          end

          self
        end

        def error(*args)
          errors.add(*args) unless args.empty?
          self
        end

        def ok?
          status
        end

        def notok?
          !ok?
        end

        private

        attr_writer :result, :status
      end

      # Tiny value object for verification codes to avoid "primitive obsession"
      Code = Struct.new :code, :attempt, keyword_init: true do
        # Creates a new code at class level
        def self.generate(attempt = nil)
          new code: rand(100_000..999_999), attempt: attempt || 0
        end

        def self.get(key)
          return if (hash = REDIS.hgetall(key).deep_symbolize_keys).empty?

          new(**hash)
        end

        def self.put(key, verification, timeout:)
          REDIS.multi do
            REDIS.hset(key, verification.to_h)
            REDIS.expire(key, timeout)
          end
        end

        # Creates a new code from the current code by incrementing the current attempt count
        def regenerate
          self.class.generate(attempt: (attempt || 0) + 1)
        end
      end

      class Phone
        TooManySendRequestError  = Class.new(Error = Class.new(StandardError))
        MissingVerifyRecordError = Class.new(Error)

        SMS_LIMIT   = 3
        SMS_TIMEOUT = 300

        attr_reader :number

        def initialize(number)
          @number = number.is_a?(TelephoneNumber::Number) ? number : TelephoneNumber.parse(number).e164_number
          @key    = "verification.#{number}"
        end

        def send(limit: SMS_LIMIT, timeout: SMS_TIMEOUT)
          raise TooManyRequestError if (verification = fresh_verification).attempt >= limit

          SMS.call(to: number, body: I18n.t('.verification.sms_code_message', code: verification.code)).tap do
            Code.put(key, verification, timeout: timeout)
          end
        end

        def verify?(code)
          raise MissingVerifyRecordError unless (current = Code.get(key))

          current.code == code
        end

        private

        attr_reader :key

        def fresh_verification
          if (current = Code.get(key))
            # Pending verification attempt found, generate a new code by incrementing attempt count
            current.regenerate
          else
            # If no previous verification attempt found, generate a new code with attempt count=0
            Code.generate
          end
        end
      end

      class Base
        attr_reader :phone, :result

        def initialize(number)
          @phone  = Phone.new number
          @result = Result.new
        end

        def self.call(number, *args)
          new(number).call(*args)
        end
      end
    end
  end
end
