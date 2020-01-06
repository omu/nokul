class RemoveSemesterAndStudentReferenceFromCourseEnrollments < ActiveRecord::Migration[6.0]
  def change
    remove_reference :course_enrollments, :student, foreign_key: true
    remove_numericality_constraint :course_enrollments, :semester, greater_than: 0
    remove_null_constraint :course_enrollments, :semester
    remove_column :course_enrollments, :semester, :integer, default: 1
  end
end
