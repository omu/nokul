# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      module Creation
        def create_debt(debt, description)
          TuitionDebt.create(
            student:       debt.student,
            academic_term: debt.academic_term,
            unit_tuition:  debt.unit_tuition,
            amount:        debt.amount,
            description:   description,
            type:          :bulk,
            due_date:      debt.due_date
          )
        end
      end
    end
  end
end
