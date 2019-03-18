# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      class Coder
        LOOP_GUARD = 1_000

        class_attribute :default_options, instance_writer: false, default: {}

        def self.inherited(base)
          dup = default_options.dup
          base.default_options = dup.each { |k, v| dup[k] = v.dup }
          super
        end

        def self.setup(**options)
          default_options.merge!(**options)
        end

        def initialize(code, **options)
          @code      = code.must_be_any_of! Code
          @processor = Processor.new @options = default_options.merge(options)

          setup if defined? setup
        end

        def run_verbose(amnesic: false)
          result, n = nil, 0 # rubocop:disable Style/ParallelAssignment

          loop do
            over_loop!(n)

            raise Error, "Too many tries: #{n}" if (n += 1) >= LOOP_GUARD

            attempt = try(amnesic: amnesic)

            break (result = attempt) if attempt

            code.next!
          end

          [result, n]
        end

        def run(**flags)
          run_verbose(**flags).first
        end

        def dry
          clone.run(amnesic: true)
        end

        DEFAULT_AVAILABLE_MAX = 10

        def available(number_of_available = DEFAULT_AVAILABLE_MAX)
          instance = clone
          result = []

          number_of_available.times do
            result << instance.run
          rescue Codification::Consumed
            break
          end

          result
        end

        protected

        attr_accessor :code
        attr_reader   :options, :processor

        def setup; end

        def memory
          @memory ||= options[:memory] || SimpleMemory.new
        end

        def over_loop!(*); end

        def try(amnesic:)
          return unless (result = processor.process(self, code.to_s, **options))

          memory.learn(result, amnesic: amnesic)
        rescue Skip
          nil
        end
      end
    end
  end
end
