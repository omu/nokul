# frozen_string_literal: true

module Articles
  module V1
    class SuccessGradeForSingleCourse < Regulation::Article
      name         'Success grade for single course'
      identifier   :success_grade_for_single_course
      register     ::V1::UndergraduateRegulation,
                   ::V1::AssociateDegreeRegulation,
                   metadata: {
                     version:      31_103,
                     number:       6,
                     sub_articles: 6,
                     store:        :default
                   }

      store do
        {
          grade: 'CC'
        }
      end

      def call
        store[:grade]
      end
    end
  end
end
