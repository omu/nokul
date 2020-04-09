# frozen_string_literal: true

module Debt
  class TuitionDebtJob < ApplicationJob
    queue_as :high

    def perform(unit_ids, term_id)
      @units   = Unit.find(unit_ids.reject(&:empty?))
      @term_id = term_id
    end

    after_perform do |debt|
      [@units].flatten.compact.each do |unit|
        unit.students.active.each do |student|
          chain   = set_chain(unit, student)
          tuition = unit.tuitions.find_by(academic_term_id: @term_id)
          next if tuition.nil?

          debt = Debt::Tuition::TuitionDebt.new(student, tuition.unit_tuitions.first)
          chain.call(debt)
        end
      end
    end

    def set_chain(unit, student)
      if unit.evening?
        Debt::Tuition::Process::EveningEducation.new(student).chain
      else
        Debt::Tuition::Process::DaytimeEducation.new(student).chain
      end
    end
  end
end
