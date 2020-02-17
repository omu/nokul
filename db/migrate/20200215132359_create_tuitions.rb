# frozen_string_literal: true

class CreateTuitions < ActiveRecord::Migration[6.0]
  def change
    create_table :tuitions do |t|
      t.references :unit, foreign_key: true
      t.references :academic_term, foreign_key: true
      t.decimal :fee, precision: 8, scale: 3, default: 0
      t.decimal :foreign_student_fee, precision: 8, scale: 3, default: 0
      t.timestamps
    end

    add_null_constraint :tuitions, :fee
    add_null_constraint :tuitions, :foreign_student_fee

    add_numericality_constraint :tuitions, :fee, greater_than_or_equal_to: 0
    add_numericality_constraint :tuitions, :foreign_student_fee, greater_than_or_equal_to: 0
  end
end
