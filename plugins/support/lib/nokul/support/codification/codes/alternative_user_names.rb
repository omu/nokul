# frozen_string_literal: true

# Generates alternative user names.
#
#   Source: ["gabriel", "garcia", "marquez"], alternative: :abbreviated
#
#   Output: [
#     "ggmarquez",
#     "ggarciam",
#     "gabrielgm",
#     "ggarciamarquez",
#     "gabrielgmarquez",
#     "gabrielgarciam",
#   ]
#
#   Source: ["gabriel", "garcia", "marquez"], alternative: :non_abbreviated
#
#   Output: [
#     "gabrielgarciamarquez",
#     "gabrielmarquez",
#     "garciamarquez",
#   ]

module Nokul
  module Support
    module Codification
      module AlternativeUserNames
        class Code < Codification::Code
          include List

          protected

          def setup
            self.list = Lists::UserNames.new(source, **options)
          end

          def sanitize(source)
            source.must_be_any_of! Array
          end

          def kernel=(index)
            @kernel = index > last_kernel ? last_kernel : index
          end
        end

        class Coder < Codification::Coder
          setup builtin_post_process: %i[safe?]
        end
      end
    end
  end
end
