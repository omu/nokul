# frozen_string_literal: true

class CreateGroupCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :group_courses do |t|
      t.references :course,
                   null: false,
                   foreign_key: true
      t.references :course_group,
                   null: false,
                   foreign_key: true
      t.timestamps
    end
  end
end
