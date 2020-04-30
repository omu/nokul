# frozen_string_literal: true

module Debt
  module Tuition
    module Process
      class DaytimeEducation
        attr_reader :student

        def initialize(student)
          @student = student
        end

        def chain
          if exceeded? || other_studentship?
            Operation::Disability.new(Operation::NoDiscount.new)
          else
            Operation::Free.new
          end
        end

        private

        def exceeded?
          student.exceeded_education_period
        end

        def other_studentship?
          student.other_studentship
        end
      end
    end
  end
end
