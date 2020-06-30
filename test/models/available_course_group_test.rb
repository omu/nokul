# frozen_string_literal: true

require 'test_helper'

class AvailableCourseGroupTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :available_course, counter_cache: :groups_count
  has_many :course_enrollments, dependent: :destroy
  has_many :lecturers, class_name:  'AvailableCourseLecturer',
                       foreign_key: :group_id,
                       inverse_of:  :group,
                       dependent:   :destroy
  has_many :saved_enrollments, class_name: 'CourseEnrollment', inverse_of: :available_course

  # validations: presence
  validates_presence_of :name

  # validations: uniqueness
  validates_uniqueness_of :name

  # validations: length
  validates_length_of :name

  # validations: nested models
  validates_presence_of_nested_model :lecturers

  # callbacks
  before_destroy :must_be_another_group

  test 'callback ensures that there must be a group other than current one' do
    AvailableCourse.reset_counters(available_courses(:elective_course).id, :groups_count)
    assert available_course_groups(:elective_course_group).destroy
    assert_not available_course_groups(:compulsory_course_group).destroy
  end

  # custom methods
  test 'quota_full? method' do
    assert available_course_groups(:elective_course_group).quota_full?
    assert_not available_course_groups(:elective_course_2_group).quota_full?
  end

  test 'number_of_enrolled_students method' do
    assert_equal 1, available_course_groups(:elective_course_group).number_of_enrolled_students
  end
end
