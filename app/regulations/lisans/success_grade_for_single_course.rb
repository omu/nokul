# frozen_string_literal: true

module Lisans
  class SuccessGradeForSingleCourse < Regulation::Article
    name         'Success grade for single course'
    identifier   :lisans_success_grade_for_single_course
    number       8
    sub_articles 6
    version      31_103
    register     V1::UndergraduateRegulation, V1::AssociateDegreeRegulation

    store do
      {
        grade: 'CC'
      }
    end

    class << self
      delegate :call, to: :new
    end

    def call
      store_data[:grade]
    end
  end
end
