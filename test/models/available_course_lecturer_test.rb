# frozen_string_literal: true

require 'test_helper'

class AvailableCourseLecturerTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :group, class_name: 'AvailableCourseGroup'
  belongs_to :lecturer, class_name: 'Employee'

  # validations: presence
  validates_presence_of :coordinator

  test 'uniqueness validations for lecturer of a group' do
    fake = available_course_lecturers(:ati_group_1_lecturer_john).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:lecturer]
    fake.group = available_course_groups(:ati_group_2)
    assert fake.valid?
  end

  # scopes
  test 'coordinator scope returns coordinator lecturers' do
    assert_includes AvailableCourseLecturer.coordinator, available_course_lecturers(:ati_group_1_lecturer_john)
    assert_not_includes AvailableCourseLecturer.coordinator, available_course_lecturers(:ati_group_1_lecturer_serhat)
  end
end
