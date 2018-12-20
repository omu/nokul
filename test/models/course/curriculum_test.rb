# frozen_string_literal: true

require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
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
  %i[
    available_courses
    courses
    course_groups
    curriculum_course_groups
    curriculum_programs
    programs
    semesters
    unit
  ].each do |relation|
    test "curriculum can communicate with #{relation}" do
      assert @curriculum.send(relation)
    end
  end

  # validations: presence
  {
    name: :name,
    semesters_count: :semesters_count,
    status: :status,
    unit: :unit,
    program_ids: :programs
  }.each do |property, error_message_key|
    test "presence validations for #{property} of a curriculum" do
      @curriculum.send("#{property}=", nil)
      assert_not @curriculum.valid?
      assert_not_empty @curriculum.errors[error_message_key]
    end
  end

  # validations: uniqueness
  test 'uniqueness validations for name of a curriculum' do
    fake = @curriculum.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:name]

    fake.unit_id = units(:cbu).id
    fake.valid?
    assert_empty fake.errors[:name]
  end

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
