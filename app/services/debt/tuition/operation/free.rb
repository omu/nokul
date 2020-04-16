# frozen_string_literal: true

module Debt
  module Tuition
    module Operation
      class Free < Handler
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
