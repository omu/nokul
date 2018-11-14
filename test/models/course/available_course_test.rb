# frozen_string_literal: true

require 'test_helper'

class AvailableCourseTest < ActiveSupport::TestCase
  # relations
  %i[
    academic_term
    curriculum
    course
    groups
  ].each do |property|
    test "a available_course can communicate with #{property}" do
      assert available_courses(:ati_fall_2017_2018).send(property)
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for course of a academic term and curriculum' do
    fake = available_courses(:ati_fall_2017_2018).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:course]
    fake.academic_term = academic_terms(:spring_2017_2018)
    assert fake.valid?
    fake.academic_term = academic_terms(:fall_2017_2018)
    fake.curriculum = curriculums(:two)
    assert fake.valid?
  end
end
