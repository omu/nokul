# frozen_string_literal: true

class EvaluationType < ApplicationRecord
  # search
  include ReferenceSearch
  include ReferenceCallbacks

  # relations
  has_many :course_evaluation_types, dependent: :destroy
  has_many :available_courses, through: :course_evaluation_types

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
