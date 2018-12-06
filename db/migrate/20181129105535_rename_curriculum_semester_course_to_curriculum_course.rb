# frozen_string_literal: true

class RenameCurriculumSemesterCourseToCurriculumCourse < ActiveRecord::Migration[5.2]
  def change
    rename_table :curriculum_semester_courses, :curriculum_courses
  end
end
