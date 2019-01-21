# frozen_string_literal: true

require 'test_helper'
require_relative './concerns/enum_for_term_test'

class CurriculumSemesterTest < ActiveSupport::TestCase
  include EnumForTermTest

  setup do
    @semester = curriculum_semesters(:one)
  end

  # relations
  %i[
    courses
    curriculum
    curriculum_courses
    curriculum_course_groups
  ].each do |relation|
    test "curriculum semester can communicate with #{relation}" do
      assert @semester.send(relation)
    end
  end

  # validations: presence
  %i[
    year
    sequence
  ].each do |property|
    test "presence validations for #{property} of a curriculum semester" do
      @semester.send("#{property}=", nil)
      assert_not @semester.valid?
      assert_not_empty @semester.errors[property]
    end
  end

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
