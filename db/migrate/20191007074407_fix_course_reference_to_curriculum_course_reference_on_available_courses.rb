class FixCourseReferenceToCurriculumCourseReferenceOnAvailableCourses < ActiveRecord::Migration[6.0]
  def change
    remove_reference :available_courses, :course, null: false, foreign_key: true
    add_reference :available_courses, :curriculum_course, null: false, foreign_key: true
  end
end
