# frozen_string_literal: true

require 'test_helper'

class AvailableCourseGroupTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :available_course, counter_cache: :groups_count
  has_many :course_enrollments, dependent: :destroy
  has_many :lecturers, class_name:  'AvailableCourseLecturer',
                       foreign_key: :group_id,
                       inverse_of:  :group,
                       dependent:   :destroy

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # validations: nested models
  validates_presence_of_nested_model :lecturers

  # custom methods
  test 'quota_full? method' do
    assert available_course_groups(:elective_course_group).quota_full?
    assert_not available_course_groups(:elective_course_2_group).quota_full?
  end

  test 'number_of_enrolled_students method' do
    assert_equal available_course_groups(:elective_course_group).number_of_enrolled_students, 1
  end
end
