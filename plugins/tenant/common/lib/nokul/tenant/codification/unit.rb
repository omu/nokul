# frozen_string_literal: true

module Nokul
  module Tenant
    module Codification
      module Unit
        mattr_accessor :const, default: ActiveSupport::InheritableOptions.new(gross_length: 3)

        module_function

        def code_generator(starting:, ending:, pattern: nil, memory:)
          [starting = starting.to_s, ending = ending.to_s].each do |code|
            code.length == const.gross_length ||
              raise(ArgumentError, "Code length must be #{const.gross_length}: #{code}")
          end

          range        = Range.new(starting, ending)
          post_process = Regexp.new(pattern) if pattern

          Support::Codification.sequential_numeric_codes range, memory: memory, post_process: post_process
        end
      end
    end
  end
end
