# frozen_string_literal: true

module Lisans
  class SelectableAdditionalEcts < Regulation::Article
    name         'Selectable Additional ECTS'
    identifier   :lisans_selectable_additional_ects
    number       10
    sub_articles 7, 8, 9, 10, 11
    version      31_103
    register     V1::UndergraduateRegulation

    store do
      {
        1.8 => 6,
        2.5 => 10,
        3   => 12,
        3.5 => 15
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
      ects = 0

      store_data.each do |key, value|
        ects = value if key <= student.gpa
      end

      ects *= 2 if student.unit.semester_type == 'yearly'

      ects
    end
  end
end
