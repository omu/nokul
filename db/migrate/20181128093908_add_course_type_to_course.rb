class AddCourseTypeToCourse < ActiveRecord::Migration[5.2]
  def change
    add_reference :courses, :course_type, foreign_key: true
  end
end
