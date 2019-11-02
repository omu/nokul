# frozen_string_literal: true

require 'test_helper'

class CourseEnrollmentTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :student
  belongs_to :available_course

  # validations: uniqueness
  test 'uniqueness validations for course_enrollment of a student' do
    fake = course_enrollments(:elective).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:student]
  end
end