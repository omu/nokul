# frozen_string_literal: true

class CreateCourseEnrollments < ActiveRecord::Migration[6.0]
  def change
    create_table :course_enrollments do |t|
      t.integer :semester
      t.references :student, null: false, foreign_key: true
      t.references :available_course, null: false, foreign_key: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end

    add_null_constraint :course_enrollments, :semester

    add_numericality_constraint :course_enrollments, :semester, greater_than: 0
    add_numericality_constraint :course_enrollments, :status, greater_than_or_equal_to: 0
  end
end
