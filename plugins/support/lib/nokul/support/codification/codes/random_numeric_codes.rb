# frozen_string_literal: true

# Generates random numbers unique in a range.

module Nokul
  module Support
    module Codification
      module RandomNumericCodes
        class Code < SequentialNumericCodes::Code
          protected

          def setup(source)
            super.to_a.shuffle!
          end
        end

        Coder = Codification::Coder
      end
    end
  end
end
