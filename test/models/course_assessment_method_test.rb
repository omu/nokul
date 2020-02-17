# frozen_string_literal: true

require 'test_helper'

class CourseAssessmentMethodTest < ActiveSupport::TestCase
  extend Support::Minitest::AssociationHelper
  extend Support::Minitest::EnumerationHelper
  extend Support::Minitest::ValidationHelper

  # enums
  enum status: { no_grade_entered: 0, draft: 1 }

  # relations
  belongs_to :assessment_method
  belongs_to :course_evaluation_type
  has_many :grades, dependent: :destroy

  # validations: presence
  validates_presence_of :percentage

  # validations: uniqueness
  validates_uniqueness_of :assessment_method

  # validations: numericality
  validates_numericality_of :percentage
  validates_numerical_range :percentage, greater_than_or_equal_to: 0
  validates_numerical_range :percentage, less_than_or_equal_to: 100
end
