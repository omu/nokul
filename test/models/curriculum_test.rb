# frozen_string_literal: true

require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  include AssociationTestModule
  include EnumerationTestModule
  include ValidationTestModule

  # constants
  {
    MAX_NUMBER_OF_SEMESTERS: 12,
    MAX_NUMBER_OF_YEARS: 6
  }.each do |constant, value|
    test "should have a #{constant} constant" do
      assert_equal Curriculum.const_get(constant), value
    end
  end

  # relations
  belongs_to :unit
  has_many :curriculum_programs
  has_many :programs
  has_many :semesters
  has_many :courses
  has_many :curriculum_course_groups
  has_many :course_groups
  has_many :available_courses

  # validations: presence
  validates_presence_of :name
  validates_presence_of :semesters_count
  validates_presence_of :status
  validates_presence_of :unit

  # validations: nested models
  validates_presence_of_nested_model :programs

  # validations: length
  validates_length_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: numericality
  validates_numericality_of :semesters_count
  validates_numerical_range :semesters_count, greater_than_or_equal_to: 0

  # enums
  has_enum :status, passive: 0, active: 1

  # custom methods
  test 'build_semester method' do
    Curriculum.reset_counters(curriculums(:one).id, :semesters_count)
    curriculums(:one).semesters.destroy_all
    curriculums(:one).build_semesters(number_of_semesters: 8, type: :periodic)
    assert_equal 8, curriculums(:one).semesters.size
    assert_equal [1, 2, 3, 4], curriculums(:one).semesters.pluck(:year).uniq

    curriculums(:one).semesters = []
    curriculums(:one).build_semesters(number_of_semesters: 2, type: :yearly)
    assert_equal 2, curriculums(:one).semesters.size
    assert_equal [1, 2], curriculums(:one).semesters.pluck(:year).uniq
  end
end
