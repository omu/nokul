# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      class NoDiscount < TuitionHandler
        include Creation

        def operate(params)
          create_debt(params, description)
        end

        def fulfill?(_params)
          true
        end

        private

        def description
          'Hiç bir indirim yapılmadan harç borcu oluşturulmuştur.'
        end
      end
    end
  end
end
