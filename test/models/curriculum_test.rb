# frozen_string_literal: true

require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

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

  # validations: length
  validates_length_of :name

  {
    program_ids: :programs
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a curriculum" do
      @curriculum.send("#{property}=", nil)
      assert_not @curriculum.valid?
      assert_not_empty @curriculum.errors[error_message_key]
    end
  end

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: numericality
  test 'numericality validations for semesters_count of a curriculum' do
    @curriculum.semesters_count = -1
    assert_not @curriculum.valid?
    assert_not_empty @curriculum.errors[:semesters_count]
  end

  # enums
  {
    status: { passive: 0, active: 1 }
  }.each do |property, hash|
    hash.each do |key, value|
      test "have a #{key} value of #{property} enum" do
        enums = Curriculum.defined_enums.with_indifferent_access
        assert_equal enums.dig(property, key), value
      end
    end
  end

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
