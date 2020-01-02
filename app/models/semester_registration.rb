# frozen_string_literal: true

class SemesterRegistration < ApplicationRecord
  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :academic_term
  belongs_to :student

  # validations
  validates :semester, uniqueness: { scope: :student_id }
  validates :semester, numericality: { greater_than: 0 }
end
