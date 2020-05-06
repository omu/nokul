# frozen_string_literal: true

class EvaluationType < ApplicationRecord
  # search
  include ReferenceSearch

  # callbacks
  before_validation :capitalize_attributes

  # relations
  has_many :course_evaluation_types, dependent: :destroy
  has_many :available_courses, through: :course_evaluation_types

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :identifier, presence: true, uniqueness: true, length: { maximum: 255 }

  private

  def capitalize_attributes
    self.name = name.capitalize_turkish if name
  end
end
