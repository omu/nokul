# frozen_string_literal: true

require 'test_helper'

class AvailableCourseLecturerTest < ActiveSupport::TestCase
  # relations
  %i[
    available_course_group
    lecturer
  ].each do |property|
    test "a available_course_lecturer can communicate with #{property}" do
      assert available_course_lecturers(:ati_group_1_lecturer_john).send(property)
    end
  end

  # scopes
  test 'coordinator scope returns coordinator lecturers' do
    lecturers = available_course_groups(:ati_group_1).lecturers
    assert lecturers.coordinator.to_a.include?(available_course_lecturers(:ati_group_1_lecturer_john))
    assert_not lecturers.coordinator.to_a.include?(available_course_lecturers(:ati_group_1_lecturer_serhat))
  end
end
