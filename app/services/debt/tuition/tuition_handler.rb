# frozen_string_literal: true

module Debt
  module Tuition
    class TuitionHandler
      attr_reader :successor

      def initialize(successor = nil)
        @successor = successor
      end

      def call(tuition)
        return operate(tuition) if fulfill?(tuition)
        return successor.call(tuition) if successor

        Rails.logger.warn("Any tuition chain operation couldn't possible for #{tuition.user.id_number}.")
      end
    end
  end
end
