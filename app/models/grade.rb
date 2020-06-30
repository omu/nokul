# frozen_string_literal: true

class Grade < ApplicationRecord
  # relations
  belongs_to :course_assessment_method
  belongs_to :course_enrollment
  belongs_to :lecturer, class_name: 'Employee'

  # validations
  validates :point, numericality: {
    only_integer:             true,
    allow_nil:                true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to:    100
  }
  validates :course_enrollment, uniqueness: { scope: :course_assessment_method_id }

  # delegates
  delegate :student, :academic_term, to: :course_enrollment
end
