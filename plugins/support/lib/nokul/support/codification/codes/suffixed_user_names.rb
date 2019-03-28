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
        mattr_reader :default_options, default: {
          alternative: :abbreviated,
          interfix: '',
          builtin_post_process: %i[safe? random_suffix]
        }

        Code  = UnsuffixedUserNames::Code
        Coder = Codification::Coder
      end
    end
  end
end
