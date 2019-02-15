# frozen_string_literal: true

require 'test_helper'

class CurriculumSemesterTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include EnumerationTestModule

  setup do
    @semester = curriculum_semesters(:one)
  end

  # relations
  belongs_to :curriculum
  has_many :courses
  has_many :curriculum_course_groups
  has_many :curriculum_courses

  # validations: presence
  validates_presence_of :year
  validates_presence_of :sequence

  # validations: numericality
  test 'numericality validations for sequence of a curriculum semester' do
    @semester.sequence = 0
    assert_not @semester.valid?
    assert_not_empty @semester.errors[:sequence]
  end

  # enums
  has_enum({ fall: 0, spring: 1, summer: 2 }, 'term')

  # custom methods
  test 'total_ects method' do
    assert_equal @semester.total_ects, 6.0
  end
end
