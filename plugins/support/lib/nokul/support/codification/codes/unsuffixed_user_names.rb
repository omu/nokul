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
        mattr_reader :default_options, default: {
          alternative: :non_abbreviated,
          interfix: '.',
          builtin_post_process: %i[safe?]
        }

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
              surname, forenames = last, clip # rubocop:disable Style/ParallelAssignment

              forenames.send(:index_combinations_of_source).map do |indexes|
                [*forenames.values_at(*indexes), surname]
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

          protected

          def take_in(source)
            source.must_be_any_of! [String]

            names = source.map(&:split).flatten.map do |name|
              name.downcase(:turkic).asciified.gsub(/[^a-zA-Z]/, '')
            end

            [*names.send(alternative), names].uniq
          end

          def take_out(value)
            value
          end

          private

          def alternative
            return SUPPORTED_ALTERNATIVES.first unless (alternative = options[:alternative])
            return alternative if SUPPORTED_ALTERNATIVES.include?(alternative)

            raise Error, "Unsupported alternative: #{alternative}"
          end
        end

        Coder = Codification::Coder
      end
    end
  end
end
