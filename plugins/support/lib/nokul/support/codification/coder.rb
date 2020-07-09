# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      class Coder
        LOOP_GUARD = 1_000

        class_attribute :default_options, instance_writer: false, default: {}

        inherited_by_conveying_attributes :default_options

        DEFAULT_AVAILABLE_LIMIT = 10
        def initialize(code, **options)
          @code      = code.must_be_any_of! Code
          @options   = default_options.merge(**options)
          @processor = Processor.new(**@options)

          setup if defined? setup
        end

        def run_verbose
          n = 0

          while (n += 1) <= LOOP_GUARD
            over_loop!(n)

            attempt = try

            return [attempt, n] if attempt

            code.next
          end

          raise Error, "Too many tries: #{n}"
        end

        def run
          run_verbose.first
        end

        def reset
          code.rewind
        end

        def available!(limit = nil)
          self.class.available(code, limit: limit, **options)
        end

        def self.available(code, limit: nil, **options)
          coder = new(code, **options).extend Dry # extend object to avoid mutating memory

          result = []

          (limit || DEFAULT_AVAILABLE_LIMIT).times do
            result << coder.run
          rescue StopIteration
            break
          end

          result
        end

        protected

        attr_reader :code, :options, :processor

        def setup; end

        def memory
          @memory ||= options[:memory] || SimpleMemory.new
        end

        def over_loop!(*); end

        def try
          return unless (result = processor.process(self, code.peek, **options))

          learn result
        rescue Skip
          nil
        end

        private

        def learn(string)
          memory.learn string
        end

        # Patch module to generate codes without mutating memory
        module Dry
          def learn(string)
            internal_memory.remember(string) if memory.remember?(string)
            internal_memory.learn(string)
          end

          private

          def internal_memory
            @internal_memory ||= SimpleMemory.new
          end
        end

        private_constant :Dry
      end
    end
  end
end
