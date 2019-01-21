# frozen_string_literal: true

class CreateCourseGroupTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :course_group_types do |t|
      t.string :name
      t.timestamps
    end

    add_presence_constraint :course_group_types, :name
    add_length_constraint :course_group_types, :name, less_than_or_equal_to: 255
  end
end
