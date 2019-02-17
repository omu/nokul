# frozen_string_literal: true

require 'test_helper'

class CourseEvaluationTypeTest < ActiveSupport::TestCase
  include AssociationTestModule
  include ValidationTestModule

  # relations
  belongs_to :available_course
  belongs_to :evaluation_type
  has_many :assessment_methods
  has_many :course_assessment_methods

  # validations: presence
  validates_presence_of :percentage

  # validations: numericality
  validates_numericality_of :percentage
  validates_numerical_range :percentage, greater_than_or_equal_to: 0
  validates_numerical_range :percentage, less_than_or_equal_to: 100

  # validations: uniqueness
  validates_uniqueness_of :evaluation_type
end
