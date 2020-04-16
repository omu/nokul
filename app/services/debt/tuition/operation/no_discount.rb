# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class NoDiscount < Handler
        include Creation

        def operate(params)
          create_debt(params, description)
        end

        def fulfill?(_params)
          true
        end

        private

        def description
          I18n.t('.tuition_management.tuition_debts.descriptions.no_discount')
        end
      end
    end
  end
end
