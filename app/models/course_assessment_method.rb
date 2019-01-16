# frozen_string_literal: true

class CourseAssessmentMethod < ApplicationRecord
  # relations
  belongs_to :course_evaluation_type
  belongs_to :assessment_method

  # validations
  validates :percentage, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }
end
