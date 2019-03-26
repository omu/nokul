# frozen_string_literal: true

# Generates unique random numbers in a range.
#
#   Source: "00003..00099", prefix: "203"
#
#   Output: "20300023", "20300089", ... (random)

module Nokul
  module Support
    module Codification
      module RandomNumericCodes
        class Code < SequentialNumericCodes::Code
          protected

          def take_in(source)
            super.to_a.shuffle!
          end
        end

        Coder = Codification::Coder
      end
    end
  end
end
