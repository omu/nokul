# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :student_number
      t.boolean :permanently_registered, default: false
      t.references :user,
                   null: false,
                   foreign_key: true
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :students, :student_number
    add_null_constraint :students, :permanently_registered
    add_length_constraint :students, :student_number, less_than_or_equal_to: 255
  end
end
