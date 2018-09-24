# frozen_string_literal: true

class CreateGroupCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :group_courses do |t|
      t.references :course
      t.references :course_unit_group
      t.timestamps
    end
  end
end
