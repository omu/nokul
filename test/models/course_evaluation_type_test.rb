# frozen_string_literal: true

require 'test_helper'

class CourseEvaluationTypeTest < ActiveSupport::TestCase
  include AssociationTestModule

  setup do
    @course_evaluation_type = course_evaluation_types(:ati_midterm_evaluation_type)
  end

  # relations
  belongs_to :available_course
  belongs_to :evaluation_type
  has_many :assessment_methods
  has_many :course_assessment_methods

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
    @course_evaluation_type.percentage = 101
    assert_not @course_evaluation_type.valid?
    assert_not_empty @course_evaluation_type.errors[:percentage]
  end

  # validations: uniqueness
  test 'uniqueness validations for evaluation type scoped with available course' do
    fake = @course_evaluation_type.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:evaluation_type]
  end
end
