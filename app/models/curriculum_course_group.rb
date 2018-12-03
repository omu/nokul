# frozen_string_literal: true

class CurriculumCourseGroup < ApplicationRecord
  # relations
  has_many :curriculum_courses, dependent: :destroy
  belongs_to :course_group
  belongs_to :curriculum_semester

  accepts_nested_attributes_for :curriculum_courses

  # validations
  validates :ects, presence: true, numericality: { greater_than: 0 }

  # delegates
  delegate :name, to: :course_group

  def build_curriculum_courses
    created_courses_ids = curriculum_courses.pluck(:course_id)
    course_group.courses.where.not(id: created_courses_ids).find_each do |course|
      curriculum_courses.build(
        course_id: course.id, curriculum_semester_id: curriculum_semester_id
      )
    end
  end
end
