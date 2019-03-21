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
        Code = UnsuffixedUserNames::Code

        class Coder < UnsuffixedUserNames::Coder
          setup builtin_post_process: superclass.default_options[:builtin_post_process] + %i[random_suffix]
        end
      end
    end
  end
end
