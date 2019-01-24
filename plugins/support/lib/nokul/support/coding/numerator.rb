# frozen_string_literal: true

module Nokul
  module Support
    module Coding
      NumeratorError = Class.new StandardError

      class AbstractNumerator
        MINIMUM_SEQUENCE_LENGTH = 3

        class_attribute :length
        class_attribute :default_options, default: {}.freeze

        def initialize(starting_sequence, **option)
          @option = ActiveSupport::InheritableOptions.new self.class.default_options.merge(**option)
          setup(starting_sequence)

          initial = starting_sequence.blank? ? first_sequence : starting_sequence
          @generator = Generator.new initial
        end

        # API

        def number
          raise NotImplementedError
        end

        def next_sequence
          generator.peek
        end

        def first_sequence
          raise NotImplementedError
        end

        protected

        attr_reader :generator, :option

        def setup(*); end
      end

      class PrefixedNumerator < AbstractNumerator
        self.length = 8
        self.default_options = { leading_prefix: '', trailing_prefix: '' }.freeze

        NUMBER_FORMAT = '%<prefix>s%<sequence>s'

        def number
          format(NUMBER_FORMAT, prefix: prefix, sequence: generator.generate)
        end

        def first_sequence
          '0' * (effective_sequence_length - 1) + '1'
        end

        protected

        def prefix
          option.leading_prefix + option.trailing_prefix
        end

        def effective_sequence_length
          self.class.length - prefix.length
        end

        def setup(starting_sequence)
          sanitize starting_sequence
        end

        def sanitize(starting_sequence)
          numerator_length_must_be_sane starting_sequence
          effective_sequence_length_must_be_sane starting_sequence
          starting_sequence_must_be_sane starting_sequence
        end

        def numerator_length_must_be_sane(*)
          length = self.class.length
          raise NumeratorError, 'Numerator length undefined' unless self.class.length
          raise NumeratorError, "Numerator length is too short: #{length}" if length < MINIMUM_SEQUENCE_LENGTH
        end

        def effective_sequence_length_must_be_sane(*)
          return if effective_sequence_length >= MINIMUM_SEQUENCE_LENGTH

          raise NumeratorError, 'Effective sequence length is too short'
        end

        def starting_sequence_must_be_sane(starting_sequence)
          return if !starting_sequence || starting_sequence.length == effective_sequence_length

          raise NumeratorError, "Incorrect length for starting sequence: #{starting_sequence}"
        end
      end
    end
  end
end
