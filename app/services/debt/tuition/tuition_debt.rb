# frozen_string_literal: true

module Debt
  module Tuition
    class TuitionDebt
      attr_reader :student, :user, :academic_term, :unit_tuition
      attr_accessor :amount

      def initialize(student, unit_tuition)
        @student = student
        @user = student.user
        @unit_tuition = unit_tuition
        @amount = unit_tuition.fee
        @academic_term = unit_tuition.academic_term
      end
    end
  end
end
