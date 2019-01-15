# frozen_string_literal: true

require 'test_helper'

class CourseEvaluationTypeTest < ActiveSupport::TestCase
  setup do
    @course_evaluation_type = course_evaluation_types(:ati_midterm_evaluation_type)
  end

  # relations
  %i[
    available_course
    evaluation_type
  ].each do |property|
    test "a course evaluation type can communicate with #{property}" do
      assert @course_evaluation_type.send(property)
    end
  end

  # validations: presence
  %i[
    percentage
  ].each do |property|
    test "presence validations for #{property} of a course evaluation type" do
      @course_evaluation_type.send("#{property}=", nil)
      assert_not @course_evaluation_type.valid?
      assert_not_empty @course_evaluation_type.errors[property]
    end
  end

  # validations: numericality
  test 'numericality validations for percentage of a course evaluation type' do
    @course_evaluation_type.percentage = -1
    assert_not @course_evaluation_type.valid?
    assert_not_empty @course_evaluation_type.errors[:percentage]
  end
end
