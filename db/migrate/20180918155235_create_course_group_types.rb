# frozen_string_literal: true

class CreateCourseGroupTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :course_group_types do |t|
      t.string :name, null: false, limit: 255
      t.timestamps
    end
  end
end
