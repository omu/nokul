# frozen_string_literal: true

class CourseEnrollment < ApplicationRecord
  # relations
  belongs_to :student
  belongs_to :available_course

  # validations
  validates :student, uniqueness: { scope: :available_course }
  validates :sequence, numericality: { greater_than: 0 }
  validates :year, numericality: { greater_than: 0 }
end
