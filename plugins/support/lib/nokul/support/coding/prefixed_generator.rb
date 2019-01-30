# frozen_string_literal: true

module Nokul
  module Support
    module Coding
      class PrefixedGenerator
        Error = Class.new ::StandardError

        MINIMUM_SEQUENCE_LENGTH = 3
        DEFAULT_NUMBER_LENGTH   = 8

        class_attribute :length, default: DEFAULT_NUMBER_LENGTH

        def initialize(starting_sequence, prefix: '', **generator_options)
          @starting_sequence = starting_sequence
          @prefix            = [*prefix].join
          @generator         = build_generator(**generator_options)
        end

        def generate
          prefix + generator.generate
        end

        def initial_sequence
          '0' * (effective_sequence_length - 1) + '1'
        end

        def next_sequence
          generator.peek
        end

        protected

        attr_reader :starting_sequence, :prefix, :generator

        def build_generator(**generator_options)
          sanitize_setup(**generator_options)
          Generator.new starting_sequence.presence || initial_sequence, **generator_options
        end

        def effective_sequence_length
          length - prefix.length
        end

        def sanitize_setup(**)
          numerator_length_must_be_sane
          effective_sequence_length_must_be_sane
          starting_sequence_must_be_sane
        end

        def numerator_length_must_be_sane
          raise Error, 'Generator length undefined' unless length
          raise Error, "Generator length is too short: #{length}" if length < MINIMUM_SEQUENCE_LENGTH
        end

        def effective_sequence_length_must_be_sane
          return if effective_sequence_length >= MINIMUM_SEQUENCE_LENGTH

          raise Error, 'Effective sequence length is too short'
        end

        def starting_sequence_must_be_sane
          return if starting_sequence.blank? || starting_sequence.length == effective_sequence_length

          raise Error, "Incorrect length for starting sequence: #{starting_sequence}"
        end
      end
    end
  end
end
