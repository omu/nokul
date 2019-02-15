# frozen_string_literal: true

require 'test_helper'

class CourseAssessmentMethodTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @course_assessment_method = course_assessment_methods(:ati_midterm_exam_assessment)
  end

  # relations
  belongs_to :assessment_method
  belongs_to :course_evaluation_type

  # validations: presence
  validates_presence_of :percentage

  # validations: numericality
  test 'numericality validations for percentage of a course assessment method' do
    @course_assessment_method.percentage = -1
    assert_not @course_assessment_method.valid?
    @course_assessment_method.percentage = 101
    assert_not @course_assessment_method.valid?
    assert_not_empty @course_assessment_method.errors[:percentage]
  end

  # validations: uniqueness
  test 'uniqueness validations for assessment method scoped with course evaluation type' do
    fake = @course_assessment_method.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:assessment_method]
  end
end
