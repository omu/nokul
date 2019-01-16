# frozen_string_literal: true

class AssessmentMethod < ApplicationRecord
  # search
  include ReferenceSearch
  include ReferenceCallbacks

  # relations
  has_many :course_assessment_methods, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
