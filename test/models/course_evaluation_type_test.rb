# frozen_string_literal: true

require 'test_helper'

class CourseEvaluationTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  setup do
    @course_evaluation_type = course_evaluation_types(:ati_midterm_evaluation_type)
  end

  # relations
  belongs_to :available_course
  belongs_to :evaluation_type
  has_many :assessment_methods
  has_many :course_assessment_methods

  # validations: presence
  validates_presence_of :percentage

  # validations: numericality
  validates_numericality_of(:percentage)
  validates_numerical_range(:percentage, :greater_than_or_equal_to, 0)
  validates_numerical_range(:percentage, :less_than_or_equal_to, 100)

  # validations: uniqueness
  test 'uniqueness validations for evaluation type scoped with available course' do
    fake = @course_evaluation_type.dup
    assert_not fake.valid?
    assert_not_empty fake.errors[:evaluation_type]
  end
end
