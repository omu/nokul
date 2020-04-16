# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class Scholarship < Handler
        def operate(_params)
          nil
        end

        def fulfill?(params)
          params.student.scholarship?
        end
      end
    end
  end
end
