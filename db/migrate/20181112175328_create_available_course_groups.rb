# frozen_string_literal: true

class CreateAvailableCourseGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :available_course_groups do |t|
      t.string :name
      t.integer :quota
      t.references :available_course,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :available_course_groups, :name
    add_length_constraint :available_course_groups, :name, less_than_or_equal_to: 255
    add_numericality_constraint :available_course_groups, :quota,
                                greater_than_or_equal_to: 0
  end
end
