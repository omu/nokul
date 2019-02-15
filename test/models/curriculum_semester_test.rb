# frozen_string_literal: true

require 'test_helper'
require_relative './concerns/enum_for_term_test'

class CurriculumSemesterTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include EnumForTermTest

  setup do
    @semester = curriculum_semesters(:one)
  end

  # relations
  has_many :curriculum_courses
  has_many :curriculum_course_groups
  has_many :courses
  belongs_to :curriculum

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
  test_term_enum(CurriculumSemester)

  # custom methods
  test 'total_ects method' do
    assert_equal @semester.total_ects, 6.0
  end
end
