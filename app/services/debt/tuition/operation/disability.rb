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
          I18n.t('.tuition_management.tuition_debts.descriptions.disability')
        end
      end
    end
  end
end
