# frozen_string_literal: true

class AddCurriculumCourseGroupAndTypeToCurriculumCourse < ActiveRecord::Migration[5.2]
  def change
    add_reference :curriculum_courses, :curriculum_course_group, foreign_key: true
    add_column :curriculum_courses, :type, :integer
  end
end
