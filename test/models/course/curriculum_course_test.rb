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
    curriculum_course_group
  ].each do |relation|
    test "curriculum course can communicate with #{relation}" do
      assert @curriculum_course.respond_to? relation
    end
  end

  # validations: presence
  {
    course_id: :course,
    curriculum_semester_id: :curriculum_semester,
    ects: :ects
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a curriculum course" do
      @curriculum_course.send("#{property}=", nil)
      assert_not @curriculum_course.valid?
      assert_not_empty @curriculum_course.errors[error_message_key]
    end
  end

  # validations: numericality
  test 'numericality validations for ects of a curriculum course' do
    @curriculum_course.ects = 0
    assert_not @curriculum_course.valid?
    assert_not_empty @curriculum_course.errors[:ects]
  end

  # enums
  {
    type: { compulsory: 0, elective: 1 }
  }.each do |property, hash|
    hash.each do |key, value|
      test "have a #{key} value of #{property} enum" do
        enums = CurriculumCourse.defined_enums.with_indifferent_access
        assert_equal enums.dig(property, key), value
      end
    end
  end

  # callbacks
  test 'callbacks must set value the type for a curriculum course' do
    curriculum_course = @curriculum_course.dup
    curriculum_course.course = courses(:test)
    curriculum_course.save
    assert_equal 'compulsory', curriculum_course.type
  end
end
