# frozen_string_literal: true

require 'test_helper'

class AvailableCourseTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::CallbackHelper

  # relations
  belongs_to :academic_term
  belongs_to :coordinator, class_name: 'Employee'
  belongs_to :curriculum_course
  belongs_to :curriculum
  belongs_to :unit
  has_many :evaluation_types, class_name: 'CourseEvaluationType', dependent: :destroy
  has_many :course_assessment_methods, through: :evaluation_types
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy
  has_many :lecturers, through: :groups
  has_many :course_enrollments, dependent: :destroy
  has_many :saved_enrollments, class_name: 'CourseEnrollment', inverse_of: :available_course
  accepts_nested_attributes_for :groups, allow_destroy: true

  # callbacks
  before_validation :assign_academic_term

  # validations: uniqueness
  test 'uniqueness validations for available_course of a course' do
    fake = available_courses(:ati_fall_2018_2019).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:curriculum_course]
  end

  # scopes
  test 'without_ids returns available courses without given ids' do
    available_course = available_courses(:elective_course)
    assert_not_includes AvailableCourse.without_ids(available_course.id), available_course
  end

  test 'compulsories returns compulsory available courses' do
    available_course = available_courses(:compulsory_course)
    assert_includes AvailableCourse.compulsories, available_course
  end

  test 'electives returns elective available courses' do
    available_course = available_courses(:elective_course)
    assert_includes AvailableCourse.electives, available_course
  end

  # custom methods
  test 'quota_full? method' do
    assert available_courses(:old_course).quota_full?
    assert_not available_courses(:elective_course).quota_full?
  end

  test 'enrollable_groups method' do
    enrollable_groups = available_courses(:elective_course).enrollable_groups
    assert_includes enrollable_groups, available_course_groups(:elective_course_group_2)
    assert_not_includes enrollable_groups, available_course_groups(:elective_course_group)
  end

  test 'number_of_enrolled_students method' do
    assert_equal 2, available_courses(:elective_course).number_of_enrolled_students
  end

  test 'groups_under_authority_of employee method' do
    groups = available_courses(:elective_course).groups_under_authority_of(employees(:serhat_active))
    assert_includes groups, available_course_groups(:elective_course_group)
    assert_not_includes groups, available_course_groups(:elective_course_group_2)
  end

  test 'enrollments_under_authority_of employee method' do
    enrollments = available_courses(:elective_course).enrollments_under_authority_of(employees(:serhat_active))
    assert_includes enrollments, course_enrollments(:elective)
    assert_not_includes enrollments, course_enrollments(:johns_enrollment)
  end
end
