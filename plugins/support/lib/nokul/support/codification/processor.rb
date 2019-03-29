# frozen_string_literal: true

require 'securerandom'

module Nokul
  module Support
    module Codification
      class Processor
        class_attribute :processors, instance_writer: false, default: {}

        inherited_by_conveying_attributes :processors

        def self.skip(string, expr = false)
          expr ? string : raise(Skip, string)
        end

        def self.define(name, &block)
          processors[name] = block
        end

        define :non_offensive? do |string|
          !string.inside_offensives?
        end

        define :non_reserved? do |string|
          !string.inside_reserved?
        end

        define :safe? do |string|
          !string.inside_offensives? && !string.inside_reserved?
        end

        DEFAULT_RANDOM_SEP = '.'
        DEFAULT_RANDOM_LEN = 3

        define :random_suffix do |string, **options|
          random_suffix = SecureRandom.random_number_string options.fetch(:random_suffix_length, DEFAULT_RANDOM_LEN)

          string + options.fetch(:random_suffix_separator, DEFAULT_RANDOM_SEP) + random_suffix
        rescue StopIteration
          Processor.skip string
        end

        def initialize(**options)
          @processors = build options.dup.extract!(:builtin_post_process, :post_process).values.flatten.compact
        end

        def process(instance, string, **options)
          processors.inject(string) { |result, processor| instance.instance_exec(result, **options, &processor) }
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
          proc { |string, *args| Processor.skip string, yield(string, *args) }
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
