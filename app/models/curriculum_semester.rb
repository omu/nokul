# frozen_string_literal: true

class CurriculumSemester < ApplicationRecord
  # relations
  has_many :curriculum_semester_courses, dependent: :destroy
  has_many :courses, through: :curriculum_semester_courses
  belongs_to :curriculum, counter_cache: :semesters_count, inverse_of: :semesters

  # validations
  validates :name, presence: true, uniqueness: { scope: :curriculum_id }
  validates :sequence, numericality: { greater_than: 0 }, uniqueness: { scope: :curriculum_id }

  # custom methods
  def available_courses(add_courses: [])
    courses = curriculum.unit.courses.active.where.not(id: curriculum.courses.ids)
    add_courses.delete(nil)
    add_courses.present? ? (courses.to_a + add_courses) : courses
  end
end
