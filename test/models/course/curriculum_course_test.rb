# frozen_string_literal: true

require 'test_helper'

class CurriculumCourseTest < ActiveSupport::TestCase
  setup do
    @curriculum_course = curriculum_courses(:one)
  end

  # relations
  %i[
    course
    curriculum_semester
  ].each do |relation|
    test "curriculum semester course can communicate with #{relation}" do
      assert @curriculum_course.send(relation)
    end
  end

  # validations: presence
  {
    course_id: :course,
    curriculum_semester_id: :curriculum_semester,
    ects: :ects
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a curriculum semester course" do
      @curriculum_course.send("#{property}=", nil)
      assert_not @curriculum_course.valid?
      assert_not_empty @curriculum_course.errors[error_message_key]
    end
  end

  # validations: numericality
  test 'numericality validations for ects of a curriculum semester course' do
    @curriculum_course.ects = 0
    assert_not @curriculum_course.valid?
    assert_not_empty @curriculum_course.errors[:ects]
  end
end
