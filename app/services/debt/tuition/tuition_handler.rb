# frozen_string_literal: true

module Debt
  module Tuition
    class TuitionHandler
      attr_reader :successor

      def initialize(successor = nil)
        @successor = successor
      end

      def call(tuition)
        return compute(tuition) if fulfill?(tuition)
        return successor.call(tuition) if successor

        Rails.logger.info "Any tuition chain operation couldn't possible for #{tuition.user.id_number}."
      end
    end
  end
end
