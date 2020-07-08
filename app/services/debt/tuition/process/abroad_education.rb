# frozen_string_literal: true

module Debt
  module Tuition
    module Process
      class AbroadEducation
        attr_reader :student

        def initialize(student)
          @student = student
        end

        def chain
          if student.exceeded_education_period
            Operation::Disability.new(Operation::NoDiscount.new)
          else
            Operation::Scholarship.new(Operation::Disability.new(Operation::NoDiscount.new))
          end
        end
      end
    end
  end
end
