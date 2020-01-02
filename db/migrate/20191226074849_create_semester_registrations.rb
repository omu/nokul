# frozen_string_literal: true

class CreateSemesterRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :semester_registrations do |t|
      t.integer :semester
      t.integer :status, null: false, default: 0
      t.references :academic_term, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.timestamps
    end

    add_null_constraint :semester_registrations, :semester

    add_numericality_constraint :semester_registrations, :semester, greater_than: 0
    add_numericality_constraint :semester_registrations, :status, greater_than_or_equal_to: 0
  end
end
