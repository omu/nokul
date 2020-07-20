# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      class Code
        def initialize(source, **options)
          @options = options
          @enum    = take_in(source).to_enum
        end

        def next
          emit { take_out enum.next }
        end

        def rewind
          tap { enum.rewind }
        end

        def peek
          emit { take_out enum.peek }
        end

        protected

        attr_reader :enum, :options

        def take_in(_source)
          raise NotImplementedError
        end

        def take_out(_value)
          raise NotImplementedError
        end

        private

        def emit
          Array(yield).join_affixed(**options)
        end
      end
    end
  end
end
