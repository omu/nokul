# frozen_string_literal: true

class CourseEnrollment < ApplicationRecord
  # enums
  enum status: { draft: 0, saved: 1 }

  # relations
  belongs_to :available_course
  belongs_to :available_course_group
  belongs_to :semester_registration
  has_many :grades, dependent: :destroy

  # validations
  validates :available_course, uniqueness: { scope: :semester_registration_id }

  # delegates
  delegate :ects, to: :available_course
  delegate :student, to: :semester_registration

  # custom methods
  def grade_of(assessment)
    grades.find_by(course_assessment_method: assessment)
  end
end
