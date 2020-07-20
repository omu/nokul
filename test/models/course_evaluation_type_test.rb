# frozen_string_literal: true

require 'test_helper'

class CourseEvaluationTypeTest < ActiveSupport::TestCase
  extend Nokul::Support::Minitest::AssociationHelper
  extend Nokul::Support::Minitest::ValidationHelper

  # relations
  belongs_to :available_course
  belongs_to :evaluation_type
  has_many :course_assessment_methods, dependent: :destroy
  has_many :assessment_methods, through: :course_assessment_methods
  accepts_nested_attributes_for :course_assessment_methods, allow_destroy: true

  # validations: presence
  validates_presence_of :percentage

  # validations: numericality
  validates_numericality_of :percentage
  validates_numerical_range :percentage, greater_than_or_equal_to: 0
  validates_numerical_range :percentage, less_than_or_equal_to: 100

  # validations: uniqueness
  validates_uniqueness_of :evaluation_type
end
