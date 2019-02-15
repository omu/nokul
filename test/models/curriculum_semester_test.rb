# frozen_string_literal: true

require 'test_helper'

class CurriculumSemesterTest < ActiveSupport::TestCase
  include AssociationTestModule
  include EnumerationTestModule
  include ValidationTestModule

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
  validates_numericality_of(:sequence)
  validates_numerical_range(:sequence, :greater_than, 0)

  # enums
  has_enum({ fall: 0, spring: 1, summer: 2 }, 'term')

  # custom methods
  test 'total_ects method' do
    assert_equal @semester.total_ects, 6.0
  end
end
