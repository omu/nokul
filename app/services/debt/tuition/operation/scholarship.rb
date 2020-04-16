# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class Scholarship < Handler
        def fulfill?(params)
          params.student.scholarship?
        end
      end
    end
  end
end
