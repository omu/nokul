# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :student_number, unique: true, null: false
      t.references :user, foreign_key: true
      t.references :unit, foreign_key: true
      t.timestamps
    end
  end
end
