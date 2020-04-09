# frozen_string_literal: true

module Debt
  class TuitionDebtJob < ApplicationJob
    queue_as :high

    def perform(unit_ids, term_id)
      units = Unit.find(unit_ids.reject(&:empty?))

      Debt::Tuition::Dispatch.perform([units].flatten.compact, term_id)
    end
  end
end
