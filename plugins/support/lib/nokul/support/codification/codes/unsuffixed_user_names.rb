# frozen_string_literal: true

# Generates random suffixed user names.
#
#   Source: ["gabriel", "garcia", "marquez"]
#
#   Output: "ggmarquez", ...

module Nokul
  module Support
    module Codification
      module UnsuffixedUserNames
        SUPPORTED_ALTERNATIVES = Set.new %i[abbreviated non_abbreviated]

        module Alternatives
          refine Array do
            def abbreviated
              result = []
              index_combinations_of_source.each do |indexes|
                alternative = clone
                indexes.each { |i| alternative[i] = alternative[i].first }
                result << alternative
              end

              result
            end

            def non_abbreviated
              surname = last
              forenames = clip

              result = []
              forenames.size.downto(1).each do |n|
                result.concat forenames.combination(n).to_a
              end

              result.map { |alternative| [*alternative, surname] }.sort_by(&:length)
            end

            private

            def index_combinations_of_source
              original = map.with_index.map { |*, i| i }.to_a

              indexes = []
              (size - 1).downto(1).each do |n|
                indexes.concat original.combination(n).to_a
              end

              indexes
            end
          end
        end

        class Code < Codification::Code
          using Alternatives

          def emit
            peek
          end

          protected

          def convert(source)
            source.must_be_any_of! [String]

            [*source.send(alternative), source].uniq
          end

          private

          def alternative
            return SUPPORTED_ALTERNATIVES.first unless (alternative = options[:alternative])
            return alternative if SUPPORTED_ALTERNATIVES.include?(alternative)

            raise Error, "Unsupported alternative: #{alternative}"
          end
        end

        class Coder < Codification::Coder
          setup builtin_post_process: %i[safe?]
        end
      end
    end
  end
end
