# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      class Scholarship < TuitionHandler
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
