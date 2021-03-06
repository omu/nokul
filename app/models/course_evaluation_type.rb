# frozen_string_literal: true

class CourseEvaluationType < ApplicationRecord
  # relations
  belongs_to :available_course
  belongs_to :evaluation_type
  has_many :course_assessment_methods, dependent: :destroy
  has_many :assessment_methods, through: :course_assessment_methods
  has_many :saved_enrollments, through: :available_course
  accepts_nested_attributes_for :course_assessment_methods, allow_destroy: true, reject_if: :all_blank

  # validations
  validates :percentage, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to:    100
  }

  validates :evaluation_type, uniqueness: { scope: :available_course }
  validates_with CourseEvaluationTypeValidator

  # delegations
  delegate :identifier, :name, to: :evaluation_type
end
