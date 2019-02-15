# frozen_string_literal: true

require 'test_helper'

class CurriculumCourseGroupTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @curriculum_course_group = curriculum_course_groups(:one)
  end

  # relations
  belongs_to :course_group
  belongs_to :curriculum_semester
  has_many :courses
  has_many :curriculum_courses

  # validations: presence
  validates_presence_of :course_group
  validates_presence_of :curriculum_semester
  validates_presence_of :ects

  # validations: uniqueness
  validates_uniqueness_of :course_group_id

  # validations: numericality
  test 'numericality validations for ects of a curriculum course group' do
    @curriculum_course_group.ects = 0
    assert_not @curriculum_course_group.valid?
    assert_not_empty @curriculum_course_group.errors[:ects]
  end

  # delegates
  test 'must have a name method' do
    assert_equal @curriculum_course_group.name, @curriculum_course_group.course_group.name
  end
end
