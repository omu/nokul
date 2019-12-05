# frozen_string_literal: true

require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # constants
  {
    MAX_NUMBER_OF_SEMESTERS: 12,
    MAX_NUMBER_OF_YEARS:     6
  }.each do |constant, value|
    test "should have a #{constant} constant" do
      assert_equal Curriculum.const_get(constant), value
    end
  end

  # relations
  belongs_to :unit
  has_many :available_courses, dependent: :destroy
  has_many :curriculum_programs, dependent: :destroy
  has_many :programs, through: :curriculum_programs,
                      source:  :unit
  has_many :semesters, class_name: 'CurriculumSemester',
                       inverse_of: :curriculum,
                       dependent:  :destroy
  has_many :courses, through: :semesters
  has_many :curriculum_course_groups, through: :semesters
  has_many :course_groups, through: :curriculum_course_groups
  accepts_nested_attributes_for :semesters, allow_destroy: true

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
  enum status: { passive: 0, active: 1 }

  # custom methods
  test 'build_semester method' do
    curriculum = curriculums(:one)
    Curriculum.reset_counters(curriculum.id, :semesters_count)
    curriculum.semesters.destroy_all
    curriculum.semesters_count = 0
    curriculum.build_semesters
    assert_equal 8, curriculum.semesters.size
    assert_equal [1, 2, 3, 4], curriculum.semesters.pluck(:year).uniq
  end
end
