# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      module Creation
        def create_debt(params, description)
          ::TuitionDebt.create(
            student:       params.student,
            academic_term: params.academic_term,
            unit_tuition:  params.unit_tuition,
            amount:        params.amount,
            description:   description
          )
        end
      end
    end
  end
end
