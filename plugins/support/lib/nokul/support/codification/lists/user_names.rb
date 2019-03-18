# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      module Lists
        class UserNames < List
          module Supported
            DEFAULT_ALTERNATIVE = :abbreviated

            def self.supported(alternative = nil)
              return DEFAULT_ALTERNATIVE unless alternative

              alternative = alternative.to_sym
              return alternative if instance_methods.include? alternative

              raise Error, "Unknown alternative: #{alternative}"
            end

            def abbreviated
              result = []
              index_combinations_of_source.each do |indexes|
                alternative = source.clone
                indexes.each { |i| alternative[i] = alternative[i].first }
                result << alternative
              end

              result
            end

            def non_abbreviated
              surname = source.last
              forenames = source.clip

              result = []
              forenames.size.downto(1).each do |n|
                result.concat forenames.combination(n).to_a
              end

              result.map { |alternative| [*alternative, surname] }.sort_by(&:length)
            end

            private

            def index_combinations_of_source
              original = source.map.with_index.map { |*, i| i }.to_a

              indexes = []
              (source.size - 1).downto(1).each do |n|
                indexes.concat original.combination(n).to_a
              end

              indexes
            end
          end

          include Supported

          protected

          def sanitize(source)
            source.must_be_any_of! [String]
          end

          def generate(**options)
            [*send(Supported.supported(options[:alternative])), source].uniq
          end
        end
      end
    end
  end
end
