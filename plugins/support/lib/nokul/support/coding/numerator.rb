# frozen_string_literal: true

module Nokul
  module Support
    module Coding
      NumeratorError = Class.new StandardError

      class AbstractNumerator
        MINIMUM_SEQUENCE_LENGTH = 3

        class_attribute :length, default: 8

        def initialize(starting_sequence, **setup)
          setup(starting_sequence, **setup)

          initial = starting_sequence.blank? ? first_sequence : starting_sequence
          @generator = Generator.new initial
        end

        def next_sequence
          generator.peek
        end

        def first_sequence
          raise NotImplementedError
        end

        protected

        attr_reader :generator

        def setup(*, **)
          raise NotImplementedError
        end
      end

      class PrefixedNumerator < AbstractNumerator
        NUMBER_FORMAT = '%<leading_prefix>s%<trailing_prefix>s%<sequence>s'

        def number
          format(NUMBER_FORMAT, leading_prefix: leading_prefix,
                                trailing_prefix: trailing_prefix,
                                sequence: generator.generate)
        end

        def first_sequence
          '0' * (effective_sequence_length(leading_prefix: leading_prefix, trailing_prefix: trailing_prefix) - 1) + '1'
        end

        protected

        attr_accessor :starting_sequence, :length, :leading_prefix, :trailing_prefix

        def setup(starting_sequence, **setup)
          sanitize(starting_sequence, **setup)

          self.leading_prefix = setup[:leading_prefix]&.to_s || ''
          self.trailing_prefix = setup[:trailing_prefix]&.to_s || ''
        end

        def sanitize(starting_sequence, **setup)
          numerator_length_must_be_sane starting_sequence, **setup
          effective_sequence_length_must_be_sane starting_sequence, **setup
          starting_sequence_must_be_sane starting_sequence, **setup
        end

        def effective_sequence_length(**setup)
          self.class.length - (setup[:leading_prefix] || '').length - (setup[:trailing_prefix] || '').length
        end

        def numerator_length_must_be_sane(*, **)
          length = self.class.length
          raise NumeratorError, 'Numerator length undefined' unless self.class.length
          raise NumeratorError, "Incorrect sequence length: #{length}" if length < MINIMUM_SEQUENCE_LENGTH
        end

        def effective_sequence_length_must_be_sane(*, **setup)
          return if effective_sequence_length(**setup) >= MINIMUM_SEQUENCE_LENGTH

          raise NumeratorError, 'Wrong length for sequence'
        end

        def starting_sequence_must_be_sane(starting_sequence, **setup)
          return if !starting_sequence || starting_sequence.length == effective_sequence_length(**setup)

          raise NumeratorError, "Incorrect length for starting sequence: #{starting_sequence}"
        end
      end
    end
  end
end
