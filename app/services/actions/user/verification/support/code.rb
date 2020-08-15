# frozen_string_literal: true

module Actions
  module User
    module Verification
      # Tiny value object for verification codes to avoid "primitive obsession"
      Code = Struct.new :code, :attempt, keyword_init: true do
        # Creates a new code at class level
        def self.generate(attempt = 0)
          new code: rand(100_000..999_999), verified: false, attempt: attempt
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
          self.class.generate attempt: attempt + 1
        end
      end
    end
  end
end
