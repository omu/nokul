# frozen_string_literal: true

require_relative '../operation/scholarship'
require_relative '../operation/disability'
require_relative '../operation/no_discount'

module Debt
  module Tuition
    module Process
      class EveningEducation
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
