# frozen_string_literal: true

# Generates random numbers unique in a range.

module Nokul
  module Support
    module Codification
      module RandomNumericCodes
        class Code < Codification::Code
          include List

          DEFAULT_BASE = 10

          protected

          attr_reader :base, :length

          def setup
            self.list = source.to_a.shuffle!

            @base    = options[:base]   || DEFAULT_BASE
            @length  = options[:length] || Math.log(@list.size - 1, @base).to_i + 1
          end

          def strings
            list[kernel].to_string(length, base)
          end

          private

          def sanitize(source)
            source.must_be_any_of! Range
          end
        end

        Coder = Codification::Coder
      end
    end
  end
end
