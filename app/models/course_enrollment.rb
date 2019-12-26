# frozen_string_literal: true

class CourseEnrollment < ApplicationRecord
  # callbacks
  before_validation :assign_semester

  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :student
  belongs_to :available_course

  # validations
  validates :student, uniqueness: { scope: :available_course }
  validates :semester, numericality: { greater_than: 0 }

  # delegates
  delegate :ects, to: :available_course

  private

  def assign_semester
    self.semester = student&.semester
  end
end
