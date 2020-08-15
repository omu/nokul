# frozen_string_literal: true

module Actions
  module User
    module Verification
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

          SMS.call(to: number, body: I18n.t('.verification.sms_code_message', code: verification.code))
          Code.put(key, verification, timeout: timeout)
        end

        def verify(code)
          raise MissingVerifyRecordError unless (current = Code.get)

          current.code == code
        end

        private

        attr_reader :key

        def fresh_verification
          if (current = Code.get)
            # Pending verification attempt found, generate a new code by incrementing attempt count
            current.regenerate
          else
            # If no previous verification attempt found, generate a new code with attempt count=0
            Code.generate
          end
        end
      end
    end
  end
end
