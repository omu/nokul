# frozen_string_literal: true

module Actions
  module User
    module Verification
      class Base
        attr_reader :phone, :errors

        def initialize(number)
          @phone  = Phone.new number
          @result = Result.new
        end

        def call(*args)
          run(*args)
          result
        end

        def self.call(number, *args)
          new(number).call(*args)
        end
      end
    end
  end
end
