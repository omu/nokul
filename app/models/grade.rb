# frozen_string_literal: true

class Grade < ApplicationRecord
  # relations
  belongs_to :course_assessment_method
  belongs_to :course_enrollment

  # validations
  validates :point, numericality: {
    only_integer:             true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to:    100
  }
  validates :course_enrollment, uniqueness: { scope: :course_assessment_method_id }
end
