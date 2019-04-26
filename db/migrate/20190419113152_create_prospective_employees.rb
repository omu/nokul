# frozen_string_literal: true

class CreateProspectiveEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :prospective_employees do |t|
      t.string :id_number
      t.string :first_name
      t.string :last_name
      t.date :date_of_birth
      t.integer :gender
      t.string :email
      t.string :mobile_phone
      t.string :staff_number
      t.references :unit, foreign_key: true
      t.references :title, foreign_key: true
      t.boolean :archived, default: false
      t.timestamps
    end

    add_presence_constraint :prospective_employees, :email
    add_presence_constraint :prospective_employees, :id_number
    add_presence_constraint :prospective_employees, :first_name
    add_presence_constraint :prospective_employees, :last_name
    add_presence_constraint :prospective_employees, :staff_number

    add_length_constraint :prospective_employees, :id_number, equal_to: 11
    add_length_constraint :prospective_employees, :first_name, less_than_or_equal_to: 255
    add_length_constraint :prospective_employees, :last_name, less_than_or_equal_to: 255
    add_length_constraint :prospective_employees, :email, less_than_or_equal_to: 255
    add_length_constraint :prospective_employees, :mobile_phone, less_than_or_equal_to: 255
    add_length_constraint :prospective_employees, :staff_number, less_than_or_equal_to: 255

    add_null_constraint :prospective_employees, :date_of_birth
    add_null_constraint :prospective_employees, :gender
    add_null_constraint :prospective_employees, :archived

    add_numericality_constraint :prospective_employees, :gender, greater_than_or_equal_to: 0
  end
end
