# frozen_string_literal: true

require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule
  include EnumerationTestModule

  setup do
    @curriculum = curriculums(:one)
  end

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
  test 'numericality validations for semesters_count of a curriculum' do
    @curriculum.semesters_count = -1
    assert_not @curriculum.valid?
    assert_not_empty @curriculum.errors[:semesters_count]
  end

  # enums
  has_enum({ passive: 0, active: 1 }, 'status')

  # custom methods
  test 'build_semester method' do
    Curriculum.reset_counters(@curriculum.id, :semesters_count)
    @curriculum.semesters.destroy_all
    @curriculum.build_semesters(number_of_semesters: 8, type: :periodic)
    assert_equal 8, @curriculum.semesters.size
    assert_equal [1, 2, 3, 4], @curriculum.semesters.pluck(:year).uniq

    @curriculum.semesters = []
    @curriculum.build_semesters(number_of_semesters: 2, type: :yearly)
    assert_equal 2, @curriculum.semesters.size
    assert_equal [1, 2], @curriculum.semesters.pluck(:year).uniq
  end
end
