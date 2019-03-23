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
              index_combinations_of_source.map do |indexes|
                alternative = clone
                indexes.each { |i| alternative[i] = alternative[i].first }
                alternative
              end
            end

            def non_abbreviated
              surname, forenames = last, clip # rubocop:disable ParallelAssignment

              forenames.send(:index_combinations_of_source).map do |alternative|
                [*alternative, surname]
              end.sort_by(&:length)
            end

            private

            def index_combinations_of_source
              original = each_index.to_a
              [].concat(*(size - 1).downto(1).map { |n| original.combination(n).to_a })
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
