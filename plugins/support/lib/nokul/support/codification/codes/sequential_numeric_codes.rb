# frozen_string_literal: true

# Generates sequential numeric codes.
#
#   Source: 3, prefix: "203", length: 8
#
#   Output: "20300003", "20300004", ...

module Nokul
  module Support
    module Codification
      module SequentialNumericCodes
        class Code < Codification::Code
          DEFAULT_BASE = 10
          DEFAULT_LEN  = 4

          protected

          attr_reader :base, :length

          def setup
            @base   = options[:base]   || DEFAULT_BASE
            @length = options[:length] || DEFAULT_LEN
          end

          def initial_kernel
            source
          end

          def next_kernel
            kernel.succ
          end

          def last_kernel
            @last_kernel ||= base**length - 1
          end

          def strings
            kernel.to_string(length, base)
          end

          private

          def sanitize(source)
            source.must_be_any_of! Integer
          end
        end

        Coder = Codification::Coder
      end
    end
  end
end
