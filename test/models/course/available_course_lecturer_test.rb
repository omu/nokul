# frozen_string_literal: true

require 'test_helper'

class AvailableCourseLecturerTest < ActiveSupport::TestCase
  setup do
    @course_lecturer = available_course_lecturers(:ati_group_1_lecturer_john)
  end

  # relations
  %i[
    group
    lecturer
  ].each do |property|
    test "a available_course_lecturer can communicate with #{property}" do
      assert @course_lecturer.send(property)
    end
  end

  # validations: presence
  test 'should not save available_course_group without coordinator info' do
    @course_lecturer.coordinator = nil
    assert_not @course_lecturer.valid?
    assert_not_empty @course_lecturer.errors[:coordinator]
  end

  # validations: uniqueness
  test 'uniqueness validations for lecturer of a group' do
    fake = @course_lecturer.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:lecturer]
    fake.group = available_course_groups(:ati_fall_2017_2018)
    assert fake.valid?
  end

  # scopes
  test 'coordinator scope returns coordinator lecturers' do
    assert_includes AvailableCourseLecturer.coordinator, @course_lecturer
    assert_not_includes AvailableCourseLecturer.coordinator, available_course_lecturers(:ati_group_1_lecturer_serhat)
  end
end
