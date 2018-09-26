# frozen_string_literal: true

class CreateCourseUnitGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :course_unit_groups do |t|
      t.string :name, null: false, limit: 255
      t.integer :total_ects_condition, null: false
      t.references :unit
      t.references :course_group_type
      t.timestamps
    end
  end
end
