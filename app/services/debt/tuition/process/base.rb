# frozen_string_literal: true

module Debt
  module Tuition
    module Process
      class Base
        attr_reader :student

        def initialize(student)
          @student = student
        end

        def chain
          if exceeded? || other_studentship? || preparatory_repetition?
            Operation::Disability.new(Operation::NoDiscount.new)
          else
            Operation::Scholarship.new(Operation::Disability.new(Operation::NoDiscount.new))
          end
        end

        private

        def exceeded?
          student.exceeded_education_period
        end

        def other_studentship?
          student.other_studentship
        end

        def preparatory_repetition?
          student.preparatory_class_repetition?
        end
      end
    end
  end
end
