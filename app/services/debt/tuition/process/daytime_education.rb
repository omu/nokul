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
