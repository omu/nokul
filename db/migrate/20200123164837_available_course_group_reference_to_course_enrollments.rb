# frozen_string_literal: true

class AvailableCourseGroupReferenceToCourseEnrollments < ActiveRecord::Migration[6.0]
  def change
    add_reference :course_enrollments, :available_course_group, foreign_key: true
  end
end
