# frozen_string_literal: true

require_relative '../tuition_handler'

module Debt
  module Tuition
    module Operation
      class Free < TuitionHandler
        def operate(_params)
          nil
        end

        def fulfill?(_params)
          true
        end
      end
    end
  end
end
