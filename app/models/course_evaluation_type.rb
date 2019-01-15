# frozen_string_literal: true

class CourseEvaluationType < ApplicationRecord
  # relations
  belongs_to :available_course
  belongs_to :evaluation_type

  # validations
  validates :percentage, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
