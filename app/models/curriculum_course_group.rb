# frozen_string_literal: true

class CurriculumCourseGroup < ApplicationRecord
  # relations
  has_many :curriculum_courses, dependent: :destroy
  has_many :courses, through: :curriculum_courses
  belongs_to :course_group
  belongs_to :curriculum_semester

  # nested models
  accepts_nested_attributes_for :curriculum_courses

  # validations
  validates :ects, numericality: { greater_than: 0 }
  validates :course_group_id, uniqueness: { scope: :curriculum_semester_id }

  # delegates
  delegate :name, to: :course_group

  # TODO: workaround
  def build_curriculum_courses
    courses = course_group.courses - self.courses
    courses.each do |course|
      curriculum_courses.build(
        course_id: course.id, curriculum_semester_id: curriculum_semester_id
      )
    end
    self
  end
end
