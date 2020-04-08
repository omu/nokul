# frozen_string_literal: true

require_relative '../operation/scholarship'
require_relative '../operation/disability'
require_relative '../operation/no_discount'

module Debt
  module Tuition
    module Process
      class DaytimeEducation
        attr_reader :student

        delegate :exceeded_education_period, to: :student

        def initialize(student)
          @student = student
        end

        def chain
          if exceeded? || other_studentship?
            Operation::Disability.new(Operation::NoDiscount.new)
          else
            Operation::Scholarship.new(Operation::Disability.new(Operation::NoDiscount.new))
          end
        end

        private

        def exceeded?
          student.exceeded_education_period
        end

        # TODO: This information shouldn't be obtained from prospective student
        def other_studentship?
          status = student.prospective_student&.obs_status
          return false if status.nil?

          !status
        end
      end
    end
  end
end
