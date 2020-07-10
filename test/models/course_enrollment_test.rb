# frozen_string_literal: true

require 'test_helper'

class CourseEnrollmentTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :available_course
  belongs_to :available_course_group
  belongs_to :semester_registration
  has_many :grades, dependent: :destroy

  # validations: uniqueness
  test 'uniqueness validations for course_enrollment of a available_course' do
    fake = course_enrollments(:elective).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:available_course]
  end

  # delegates
  %i[
    ects
    student
  ].each do |property|
    test "a course_enrollment reach #{property} parameter" do
      assert course_enrollments(:elective).public_send(property)
    end
  end

  # custom methods
  test 'grade_of assessment method' do
    grade = course_enrollments(:elective).grade_of(course_assessment_methods(:elective_midterm_project_assessment))
    assert_equal 50, grade.point
  end
end
