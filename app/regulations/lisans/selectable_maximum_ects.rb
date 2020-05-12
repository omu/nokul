# frozen_string_literal: true

module Lisans
  class SelectableMaximumEcts < Regulation::Article
    name       'Selectable Maximum ECTS'
    identifier :lisans_selectable_maximum_ects
    number     10
    version    31_103
    register   V1::UndergraduateRegulation

    store do
      {
        'yearly'   => 60,
        'periodic' => 30
      }
    end

    attr_reader :student

    def initialize(student)
      @student = student
    end

    class << self
      def call(student)
        new(student).call
      end
    end

    def call
      SelectableAdditionalEcts.call(student) +
        store_data.fetch(student.unit.semester_type, 0)
    end
  end
end
