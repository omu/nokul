# frozen_string_literal: true

require 'test_helper'

class CourseAssessmentMethodTest < ActiveSupport::TestCase
  setup do
    @course_assessment_method = course_assessment_methods(:ati_midterm_exam_assessment)
  end

  # relations
  %i[
    course_evaluation_type
    assessment_method
  ].each do |property|
    test "a course assessment method can communicate with #{property}" do
      assert @course_assessment_method.send(property)
    end
  end

  # validations: presence
  %i[
    percentage
  ].each do |property|
    test "presence validations for #{property} of a course assessment method" do
      @course_assessment_method.send("#{property}=", nil)
      assert_not @course_assessment_method.valid?
      assert_not_empty @course_assessment_method.errors[property]
    end
  end

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
