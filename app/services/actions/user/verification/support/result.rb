# frozen_string_literal: true

module Actions
  module User
    module Verification
      class Result
        attr_reader :errors

        def initialize
          @errors = ActiveModel::Errors.new(self)
        end

        def error(*args)
          errors.add(*args)
          self
        end

        def ok?
          errors.empty?
        end

        def notok?
          !ok?
        end
      end
    end
  end
end
