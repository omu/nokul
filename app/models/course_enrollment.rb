# frozen_string_literal: true

class CourseEnrollment < ApplicationRecord
  # relations
  belongs_to :student
  belongs_to :available_course

  # validations
  validates :student, uniqueness: { scope: :available_course }
  validates :semester, numericality: { greater_than: 0 }

  # delegates
  delegate :ects, to: :available_course
end
