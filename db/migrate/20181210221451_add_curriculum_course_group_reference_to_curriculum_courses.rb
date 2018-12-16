# frozen_string_literal: true

class AddCurriculumCourseGroupReferenceToCurriculumCourses < ActiveRecord::Migration[5.2]
  def change
    add_reference :curriculum_courses, :curriculum_course_group, foreign_key: true
  end
end
