# frozen_string_literal: true

module Debt
  module Tuition
    class TuitionDebt
      attr_reader :student, :user
      attr_accessor :amount

      def initialize(student, amount)
        @student = student
        @user = student.user
        @amount = amount
      end
    end
  end
end
