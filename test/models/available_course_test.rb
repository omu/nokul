# frozen_string_literal: true

require 'test_helper'

class AvailableCourseTest < ActiveSupport::TestCase
  setup do
    @available_course = available_courses(:ati_fall_2018_2019)
  end

  # relations
  %i[
    academic_term
    curriculum
    course
    unit
    groups
    evaluation_types
  ].each do |property|
    test "a available_course can communicate with #{property}" do
      assert @available_course.send(property)
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for course of a academic term and curriculum' do
    fake = @available_course.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:course]
    fake.course = courses(:ydi)
    assert fake.valid?
    fake.academic_term = academic_terms(:fall_2017_2018)
    fake.curriculum = curriculums(:two)
    assert fake.valid?
  end
end
