class CreateGroupCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :group_courses do |t|
      t.references :course, foreign_key: true
      t.references :course_unit_group, foreign_key: true
      t.timestamps
    end
  end
end
