# frozen_string_literal: true

class CourseEnrollment < ApplicationRecord
  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :available_course

  # validations
  validates :available_course, uniqueness: { scope: :semester_registration_id }

  # delegates
  delegate :ects, to: :available_course
end
