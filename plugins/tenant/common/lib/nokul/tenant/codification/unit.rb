# frozen_string_literal: true

module Nokul
  module Tenant
    module Codification
      module Unit
        mattr_accessor :const, default: ActiveSupport::InheritableOptions.new(gross_length: 4)

        module_function

        def code_generator(starting:, ending:, only: nil, except: nil, memory:)
          [starting = starting.to_s, ending = ending.to_s].each do |code|
            code.length == const.gross_length ||
              raise("Code length must be #{const.gross_length}: #{code}")
          end

          post_process = post_process_for(only, except)
          range        = Range.new(starting, ending)

          Support::Codification.sequential_numeric_codes range, memory: memory, post_process: post_process
        end

        Processor = Support::Codification::Processor

        def post_process_for(only, except)
          proc do |string|
            [*only].each   { |re| Processor.skip(string,  string.match?(Regexp.new(re))) } if only
            [*except].each { |re| Processor.skip(string, !string.match?(Regexp.new(re))) } if except
            string
          end
        end

        private_class_method :post_process_for
      end
    end
  end
end
