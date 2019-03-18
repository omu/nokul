# frozen_string_literal: true

module Nokul
  module Support
    module Codification
      class Processor
        class_attribute :processors, instance_writer: false, default: {}

        def self.inherited(base)
          dup = processors.dup
          base.processors = dup.each { |k, v| dup[k] = v.dup }
          super
        end

        def self.define(name, &block)
          processors[name] = block
        end

        define :non_offensive? do |string, *|
          !string.inside_offensives?
        end

        define :non_reserved? do |string, *|
          !string.inside_reserved?
        end

        define :safe? do |string, *|
          !string.inside_offensives? && !string.inside_reserved?
        end

        RANDOM_CEILING = 999
        RANDOM_TRY     = RANDOM_CEILING / 100

        define :random_suffix do |string, *|
          @_random_suffix_memory ||= SimpleMemory.new
          @_random_ceiling       ||= (respond_to?(:options) && options[:random_ceiling]) || RANDOM_CEILING

          RANDOM_TRY.times do
            suffix = secure_random_number_extension(@_random_ceiling)
            break string + suffix if @_random_suffix_memory.learn suffix
          end
        end

        def initialize(**options)
          @processors = build options.dup.extract!(:builtin_post_process, :post_process).values.flatten
        end

        def process(instance, string, *args)
          processors.inject(string) { |result, processor| instance.instance_exec(result, *args, &processor) }
        end

        def skip(string, expr)
          expr ? string : raise(Skip, string)
        end

        protected

        attr_reader :processors

        def build(args)
          args.map do |arg|
            arg.must_be_any_of! Regexp, Proc, Symbol, String

            case arg
            when Regexp         then processor_regexp(arg)
            when Proc           then arg
            when Symbol, String then processor_builtin(arg.to_s)
            end
          end
        end

        def processor_predicate
          processor = self
          proc do |string, *args|
            processor.skip string, yield(string, *args)
          end
        end

        def processor_regexp(pattern)
          processor_predicate { |string, _| string.match?(pattern) }
        end

        def processor_builtin(builtin)
          raise Error, "No such processor: #{builtin}" unless (processor = Processor.processors[builtin.to_sym])

          builtin.end_with?('?') ? processor_predicate(&processor) : processor
        end
      end
    end
  end
end
