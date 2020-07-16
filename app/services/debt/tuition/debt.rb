# frozen_string_literal: true

module Debt
  module Tuition
    class Debt
      attr_reader :academic_term, :due_date, :student, :user, :unit_tuition
      attr_accessor :amount

      def initialize(student, unit_tuition, due_date)
        @student = student
        @user = student.user
        @unit_tuition = unit_tuition
        @amount = student.abroad? ? unit_tuition.foreign_student_fee : unit_tuition.fee
        @academic_term = unit_tuition.academic_term
        @due_date = due_date
      end
    end
  end
end
