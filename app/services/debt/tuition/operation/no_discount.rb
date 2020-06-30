# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class NoDiscount < Handler
        include Creation

        def operate(debt)
          create_debt(debt, :no_discount)
        end
      end
    end
  end
end
