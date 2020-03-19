# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      class Disability < TuitionHandler
        def compute(params)
          params.amount -= (params.amount * params.user.disability_rate) / 100
        end

        def fulfill?(params)
          params.user.disabled?
        end
      end
    end
  end
end
