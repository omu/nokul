# frozen_string_literal: true

module Debt
  module Tuition
    module Dispatch
      module_function

      def perform(units, term_id, due_date)
        units.each do |unit|
          unit.students.active.each do |student|
            tuition = unit.tuitions.find_by(academic_term_id: term_id)
            next if tuition.nil?

            chain = set_chain(unit, student)
            debt  = Debt.new(student, tuition.unit_tuitions.first, due_date)
            chain.call(debt)
          end
        end
      end

      def set_chain(unit, student)
        if student.abroad?
          Process::Abroad.new(student).chain
        elsif unit.evening?
          Process::Evening.new(student).chain
        else
          Process::Daytime.new(student).chain
        end
      end
    end
  end
end
