# frozen_string_literal: true

require 'test_helper'

class CurriculumCourseTest < ActiveSupport::TestCase
  include AssociationTestModule

  setup do
    @curriculum_course = curriculum_courses(:one)
  end

  # relations
  belongs_to :course
  belongs_to :curriculum_semester

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

  # validations: uniqueness
  test 'curriculum course should be unique by curriculum' do
    fake = @curriculum_course.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:course]
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
