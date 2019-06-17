# frozen_string_literal: true

class CourseAssessmentMethod < ApplicationRecord
  # relations
  belongs_to :assessment_method
  belongs_to :course_evaluation_type

  # validations
  validates :percentage, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to:    100
  }
  validates :assessment_method, uniqueness: { scope: :course_evaluation_type }

  # delegates
  delegate :name, to: :assessment_method
end
