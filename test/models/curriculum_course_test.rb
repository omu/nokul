# frozen_string_literal: true

require 'test_helper'

class CurriculumCourseTest < ActiveSupport::TestCase
  include AssociationTestModule
  include CallbackTestModule
  include EnumerationTestModule
  include ValidationTestModule

  # relations
  belongs_to :course
  belongs_to :curriculum_semester

  # validations: presence
  validates_presence_of :course
  validates_presence_of :curriculum_semester
  validates_presence_of :ects

  # validations: numericality
  validates_numericality_of :ects
  validates_numerical_range :ects, greater_than: 0

  # validations: uniqueness
  validates_uniqueness_of :course

  # enums
  has_enum :type, compulsory: 0, elective: 1

  # callbacks
  has_validation_callback :assign_type, :before

  test 'callbacks must set value the type for a curriculum course' do
    curriculum_course = curriculum_courses(:one).dup
    curriculum_course.course = courses(:test)
    curriculum_course.save
    assert_equal 'compulsory', curriculum_course.type
  end
end
