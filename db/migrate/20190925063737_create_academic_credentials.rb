# frozen_string_literal: true

class CreateAcademicCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :academic_credentials do |t|
      t.integer :yoksis_id
      t.integer :activity
      t.references :country, foreign_key: true
      t.string :department
      t.string :discipline
      t.integer :location
      t.string :profession_name
      t.string :scientific_field
      t.integer :status
      t.string :title
      t.string :unit_name
      t.integer :unit_id
      t.integer :university_id
      t.integer :start_year
      t.integer :end_year
      t.datetime :last_update
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end

    add_null_constraint :academic_credentials, :yoksis_id
    add_null_constraint :academic_credentials, :activity
    add_null_constraint :academic_credentials, :unit_id
    add_null_constraint :academic_credentials, :university_id

    add_length_constraint :academic_credentials, :department, less_than_or_equal_to: 255
    add_length_constraint :academic_credentials, :discipline, less_than_or_equal_to: 255
    add_length_constraint :academic_credentials, :profession_name, less_than_or_equal_to: 255
    add_length_constraint :academic_credentials, :scientific_field, less_than_or_equal_to: 255
    add_length_constraint :academic_credentials, :title, less_than_or_equal_to: 255
    add_length_constraint :academic_credentials, :unit_name, less_than_or_equal_to: 255

    add_numericality_constraint :academic_credentials, :yoksis_id, greater_than_or_equal_to: 0
    add_numericality_constraint :academic_credentials, :activity, greater_than_or_equal_to: 0
    add_numericality_constraint :academic_credentials, :location, greater_than_or_equal_to: 0
    add_numericality_constraint :academic_credentials, :status, greater_than_or_equal_to: 0
    add_numericality_constraint :academic_credentials, :start_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
    add_numericality_constraint :academic_credentials, :end_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
  end
end
