# frozen_string_literal: true

module Debt
  class TuitionDebtJob < ApplicationJob
    queue_as :high

    def perform(unit_ids, term_id)
      @chain = Debt::Tuition::Process::SecondaryEducation.chain
      @units = Unit.find(unit_ids.reject(&:empty?))
      @term_id = term_id
    end

    after_perform do |debt|
      [@units].flatten.compact.each do |unit|
        unit.students.active.each do |student|
          tuition = unit.tuitions.find_by(academic_term_id: @term_id)
          debt = Debt::Tuition::TuitionDebt.new(student, tuition.unit_tuitions.first)
          @chain.call(debt)
        end
      end
    end
  end
end
