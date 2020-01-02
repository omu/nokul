# frozen_string_literal: true

class SemesterRegistration < ApplicationRecord
  # callbacks
  before_validation :assign_academic_term
  before_validation :assign_semester

  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :academic_term
  belongs_to :student
  has_many :course_enrollments, dependent: :destroy

  # validations
  validates :semester, uniqueness: { scope: :student_id }
  validates :semester, numericality: { greater_than: 0 }

  private

  def assign_academic_term
    self.academic_term = AcademicTerm.current
  end

  def assign_semester
    self.semester = student&.semester
  end
end
