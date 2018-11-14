# frozen_string_literal: true

class CreateAvailableCourseGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :available_course_groups do |t|
      t.string :name, null: false, limit: 50
      t.integer :quota
      t.references :available_course
      t.timestamps
    end
  end
end
