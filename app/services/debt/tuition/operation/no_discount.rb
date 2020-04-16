# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class NoDiscount < Handler
        include Creation

        def operate(debt)
          create_debt(debt, description)
        end

        private

        def description
          I18n.t('.tuition_management.tuition_debts.descriptions.no_discount')
        end
      end
    end
  end
end
