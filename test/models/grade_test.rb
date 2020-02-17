# frozen_string_literal: true

require 'test_helper'

class GradeTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::ValidationHelper

  # relations
  belongs_to :course_assessment_method
  belongs_to :course_enrollment

  # validations: uniqueness
  test 'uniqueness validations for grade of a course_enrollment' do
    fake = grades(:elective_midterm_project_grade).dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:course_enrollment]
  end
end
