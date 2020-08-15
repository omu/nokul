# frozen_string_literal: true

module Actions
  module User
    module Verification
      class Result
        attr_reader :errors, :status

        def initialize
          @errors = ActiveModel::Errors.new(self)
          @status = true
        end

        def error(*args)
          self.status = false
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

        attr_writer :status
      end
    end
  end
end
