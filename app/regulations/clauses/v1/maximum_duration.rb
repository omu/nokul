# frozen_string_literal: true

module Clauses
  module V1
    class MaximumDuration < Extensions::Regulation::Clause
      identifier   :maximum_duration_of_education
      register     ::V1::UndergraduateRegulation, metadata: {
        version:   31_103,
        number:    8,
        paragraph: 1,
        store:     :default
      }

      store do
        {
          2 => 4,
          4 => 7,
          5 => 8,
          6 => 9
        }
      end

      attr_reader :program

      def initialize(program, store_key: :default)
        @program   = program
        @store_key = store_key
      end

      def call
        raise ArgumentError, 'unit must be of the program type' unless program.program?

        store.fetch(program.duration)
      end
    end
  end
end
