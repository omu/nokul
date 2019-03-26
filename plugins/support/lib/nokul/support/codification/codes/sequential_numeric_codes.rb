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
          protected

          def take_in(source)
            source.must_be_any_of! String..String, String

            source.is_a?(String) ? convert_from_string(source) : convert_from_range(source)
          end

          def take_out(value)
            value.to_string(net_length, base)
          end

          attr_accessor :base, :net_length

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

            self.base, self.net_length = base_and_length_from_sample(ending)

            (starting.to_i(base)..ending.to_i(base))
          end

          def convert_from_string(source)
            base, net_length = base_and_length_from_sample(source)
            convert_from_range(source..(base**net_length - 1).to_s)
          end

          def base_and_length_from_sample(sample)
            [
              options[:base]       || base_from_string(sample),
              options[:net_length] || sample.length
            ]
          end
        end

        Coder = Codification::Coder
      end
    end
  end
end
