# frozen_string_literal: true

module Clauses
  module V1
    class SelectableMaximumEcts < Extensions::Regulation::Clause
      identifier  :selectable_maximum_ects
      register   ::V1::UndergraduateRegulation, metadata: {
        version: 30_911,
        number:  10,
        store:   :default
      }

      store do
        {
          'yearly'   => 60,
          'periodic' => 30
        }
      end

      attributes :student

      def call
        SelectableAdditionalEcts.call(student, executer: executer) +
          store.fetch(student.unit.semester_type, 0)
      end
    end
  end
end
