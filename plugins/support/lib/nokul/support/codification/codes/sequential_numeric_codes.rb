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
          def strings
            [peek].map { |number| number.to_string(length, base) }
          end

          protected

          def setup(source)
            source.must_be_any_of! String..String

            starting, ending = source.first, source.last # rubocop:disable Style/ParallelAssignment

            self.base   = options[:base]   || base_from_string(ending)
            self.length = options[:length] || ending.length

            (starting.to_i(base)..ending.to_i(base))
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
        end

        Coder = Codification::Coder
      end
    end
  end
end
