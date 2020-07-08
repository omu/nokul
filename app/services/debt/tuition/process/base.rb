# frozen_string_literal: true

module Debt
  module Tuition
    module Process
      class Base
        attr_reader :student

        def initialize(student)
          @student = student
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
