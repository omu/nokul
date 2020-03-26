# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      class Scholarship < TuitionHandler
        include Creation

        def operate(params)
          compute(params)
          create_debt(params, description)
        end

        def fulfill?(params)
          params.student.scholarship?
        end

        private

        def compute(params)
          params.amount = 1
        end

        def description
          'Burslu olduğu sembolik 1 lira borçlandırılmıştır.'
        end
      end
    end
  end
end
