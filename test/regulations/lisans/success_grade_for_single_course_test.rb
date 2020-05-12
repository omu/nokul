# frozen_string_literal: true

require 'test_helper'

module Lisans
  class SuccessGradeForSingleCourseTest < ActiveSupport::TestCase
    setup do
      @klass = Lisans::SuccessGradeForSingleCourse
    end

    test 'call' do
      assert_equal @klass.call, 'CC'
    end

    test 'properties' do
      {
        name:         'Success grade for single course',
        identifier:   :lisans_success_grade_for_single_course,
        number:       8,
        sub_articles: [6],
        version:      31_103
      }.each do |property, value|
        assert_equal @klass.public_send(property), value
      end
    end

    test 'register' do
      assert V1::UndergraduateRegulation.articles.key?(@klass.identifier)
      assert V1::AssociateDegreeRegulation.articles.key?(@klass.identifier)
    end
  end
end
