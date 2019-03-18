# frozen_string_literal: true

# Generates random suffixed user names.
#
#   Source: ["gabriel", "garcia", "marquez"]
#
#   Output: "ggmarquez.123", ...

module Nokul
  module Support
    module Codification
      module SuffixedUserNames
        class Code < Codification::Code
          include List

          protected

          attr_reader :list

          def setup
            @list = Lists::UserNames.new(source, **options)
          end

          private

          def sanitize(source)
            source.must_be_any_of! Array
          end
        end

        class Coder < Codification::Coder
          setup builtin_post_process: %i[safe? random_suffix]
        end
      end
    end
  end
end
