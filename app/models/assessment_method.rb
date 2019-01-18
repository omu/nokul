# frozen_string_literal: true

class AssessmentMethod < ApplicationRecord
  # search
  include ReferenceSearch
  include ReferenceCallbacks

  # relations
  has_many :course_assessment_methods, dependent: :destroy
  has_many :course_evaluation_types, through: :course_assessment_methods
  has_many :available_courses, through: :course_evaluation_types

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
