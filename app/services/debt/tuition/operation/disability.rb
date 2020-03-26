# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      class Disability < TuitionHandler
        include Creation

        def operate(params)
          compute(params)
          create_debt(params, description)
        end

        def fulfill?(params)
          params.user.disabled?
        end

        private

        def compute(params)
          params.amount -= (params.amount * params.user.disability_rate) / 100
        end

        def description
          'Engel durumu göz önünde bulundurularak harç borcu oluşturulmuştur.'
        end
      end
    end
  end
end
