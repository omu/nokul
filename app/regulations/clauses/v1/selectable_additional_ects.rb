# frozen_string_literal: true

module Clauses
  module V1
    class SelectableAdditionalEcts < Extensions::Regulation::Clause
      identifier   :selectable_additional_ects
      register     ::V1::UndergraduateRegulation, metadata: {
        version:   31_103,
        number:    10,
        paragraph: [7, 8, 9, 10, 11],
        store:     :default
      }

      store do
        {
          1.8 => 6,
          2.5 => 10,
          3   => 12,
          3.5 => 15
        }
      end

      attr_reader :student

      def initialize(student, store_key: :default)
        @student   = student
        @store_key = store_key
      end

      def call
        ects = 0

        store.each do |key, value|
          ects = value if key <= student.gpa
        end

        ects *= 2 if student.unit.semester_type == 'yearly'

        ects
      end
    end
  end
end
