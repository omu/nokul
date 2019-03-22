# frozen_string_literal: true

# Generates sequential numeric codes.
#
#   Source: "00003..00099", prefix: "203"
#
#   Output: "20300003", "20300004", ..., "20300099"

module Nokul
  module Support
    module Codification
      module SequentialNumericCodes
        class Code < Codification::Code
          def emit
            [peek].map { |number| number.to_string(length, base) }
          end

          protected

          def convert(source)
            source.must_be_any_of! String..String, String

            source.is_a?(String) ? convert_from_string(source) : convert_from_range(source)
          end

          attr_accessor :base, :length

          private

          def base_from_string(string)
            case string
            when /[g-zG-Z]/ then 36
            when /[a-fA-F]/ then 16
            else                 10
            end
          end

          def convert_from_range(source)
            starting, ending = source.first, source.last # rubocop:disable Style/ParallelAssignment

            self.base, self.length = base_and_length_from_sample(ending)

            (starting.to_i(base)..ending.to_i(base))
          end

          def convert_from_string(source)
            self.base, self.length = base_and_length_from_sample(source)

            starting, ending = source, (base**length - 1).to_s # rubocop:disable Style/ParallelAssignment

            (starting.to_i(base)..ending.to_i(base))
          end

          def base_and_length_from_sample(sample)
            [
              options[:base]   || base_from_string(sample),
              options[:length] || sample.length
            ]
          end
        end

        Coder = Codification::Coder
      end
    end
  end
end
