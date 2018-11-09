# frozen_string_literal: true

require 'test_helper'

class CurriculumSemesterCourseTest < ActiveSupport::TestCase
  setup do
    @semester_course = curriculum_semester_courses(:one)
  end

  # relations
  %i[
    course
    curriculum_semester
  ].each do |relation|
    test "curriculum semester course can communicate with #{relation}" do
      assert @semester_course.send(relation)
    end
  end

  # validations: presence
  {
    course_id: :course,
    curriculum_semester_id: :curriculum_semester,
    ects: :ects
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a curriculum semester course" do
      @semester_course.send("#{property}=", nil)
      assert_not @semester_course.valid?
      assert_not_empty @semester_course.errors[error_message_key]
    end
  end

  # validations: numericality
  test 'numericality validations for ects of a curriculum semester course' do
    @semester_course.ects = 0
    assert_not @semester_course.valid?
    assert_not_empty @semester_course.errors[:ects]
  end
end
