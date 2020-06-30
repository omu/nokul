# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class Scholarship < Handler
        def fulfill?(debt)
          debt.student.scholarship?
        end
      end
    end
  end
end
