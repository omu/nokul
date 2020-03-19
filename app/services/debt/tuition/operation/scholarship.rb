# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      class Scholarship < TuitionHandler
        def compute(params)
          params.amount = 0
        end

        def fulfill?(params)
          params.student.scholarship?
        end
      end
    end
  end
end
