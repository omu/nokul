# frozen_string_literal: true

class CreateCourseGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :course_groups do |t|
      t.string :name
      t.integer :total_ects_condition
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :course_group_type,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :course_groups, :name
    add_null_constraint :course_groups, :total_ects_condition
    add_length_constraint :course_groups, :name, less_than_or_equal_to: 255

    add_numericality_constraint :course_groups, :total_ects_condition,
                                greater_than_or_equal_to: 0,
                                less_than_or_equal_to: 300
  end
end
