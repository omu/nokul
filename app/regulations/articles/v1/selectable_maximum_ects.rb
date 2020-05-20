# frozen_string_literal: true

module Articles
  module V1
    class SelectableMaximumEcts < Regulation::Article
      name       'Selectable Maximum ECTS'
      identifier :selectable_maximum_ects
      register   ::V1::UndergraduateRegulation, metadata: {
        version: 31_103,
        number:  10,
        store:   :default
      }

      store do
        {
          'yearly'   => 60,
          'periodic' => 30
        }
      end

      attr_reader :student

      def initialize(student, store_key: :default)
        @student   = student
        @store_key = store_key
      end

      def call
        SelectableAdditionalEcts.call(student) +
          store.fetch(student.unit.semester_type, 0)
      end
    end
  end
end
