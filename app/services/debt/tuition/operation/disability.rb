# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class Disability < Handler
        include Creation

        def operate(debt)
          compute(debt)
          create_debt(debt, :disability)
        end

        def fulfill?(debt)
          debt.user.disabled?
        end

        private

        def compute(debt)
          debt.amount -= (debt.amount * debt.user.disability_rate) / 100
        end
      end
    end
  end
end
