# frozen_string_literal: true

class CurriculumCourseGroup < ApplicationRecord
  # relations
  has_many :curriculum_courses, dependent: :destroy
  belongs_to :course_group
  belongs_to :curriculum_semester

  # nested models
  accepts_nested_attributes_for :curriculum_courses

  # validations
  validates :ects, presence: true, numericality: { greater_than: 0 }

  # delegates
  delegate :name, to: :course_group

  # TODO: workaround
  def build_curriculum_courses
    course_group.courses.except_for(curriculum_courses.pluck(:course_id)).find_each do |course|
      curriculum_courses.build(
        course_id: course.id, curriculum_semester_id: curriculum_semester_id
      )
    end
  end
end
