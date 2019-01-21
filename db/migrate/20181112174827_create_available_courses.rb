# frozen_string_literal: true

class CreateAvailableCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :available_courses do |t|
      t.references :academic_term,
                   null: false,
                   foreign_key: true
      t.references :curriculum,
                   null: false,
                   foreign_key: true
      t.references :course,
                   null: false,
                   foreign_key: true
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :coordinator,
                   foreign_key: { to_table: :employees }
      t.integer :groups_count, default: 0
      t.boolean :assessments_approved, default: false
      t.timestamps
    end

    add_null_constraint :available_courses, :assessments_approved

    add_numericality_constraint :available_courses, :groups_count, greater_than_or_equal_to: 0
  end
end
