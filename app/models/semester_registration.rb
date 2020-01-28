# frozen_string_literal: true

class SemesterRegistration < ApplicationRecord
  # callbacks
  before_validation :assign_academic_term_and_semester

  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :academic_term
  belongs_to :student
  has_many :course_enrollments, dependent: :destroy
  has_many :available_course_groups, through: :course_enrollments

  # validations
  validates :semester, uniqueness: { scope: :student_id }, numericality: { greater_than: 0 }

  private

  def assign_academic_term_and_semester
    assign_attributes(academic_term: AcademicTerm.current, semester: student&.semester)
  end
end
