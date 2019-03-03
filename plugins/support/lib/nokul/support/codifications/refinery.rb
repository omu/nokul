# frozen_string_literal: true

module Nokul
  module Support
    module Codifications
      module Refinery
        refine String do
          def to_number(base)
            to_i(base)
          end
        end

        refine Integer do
          def to_string(base, length)
            to_s(base).upcase.rjust(length, '0')
          end
        end
      end
    end
  end
end
