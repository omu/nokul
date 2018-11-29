# frozen_string_literal: true

require 'test_helper'

class CurriculumSemesterTest < ActiveSupport::TestCase
  setup do
    @semester = curriculum_semesters(:one)
  end

  # relations
  %i[
    courses
    curriculum
    curriculum_courses
  ].each do |relation|
    test "curriculum semester can communicate with #{relation}" do
      assert @semester.send(relation)
    end
  end

  # validations: presence
  %i[
    year
    sequence
  ].each do |property|
    test "presence validations for #{property} of a curriculum semester" do
      @semester.send("#{property}=", nil)
      assert_not @semester.valid?
      assert_not_empty @semester.errors[property]
    end
  end

  # validations: numericality
  test 'numericality validations for sequence of a curriculum semester' do
    @semester.sequence = 0
    assert_not @semester.valid?
    assert_not_empty @semester.errors[:sequence]
  end

  # custom methods
  test 'available_courses method return course for curriculum' do
    courses = @semester.available_courses
    assert_includes courses, courses(:test)
    assert_not_includes courses, courses(:ati)
    assert_not_includes courses, Course.passive.first

    courses = @semester.available_courses(add_courses: [courses(:ati)])
    assert_includes courses, courses(:ati)
  end
end
