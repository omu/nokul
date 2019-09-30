# frozen_string_literal: true

class CreateEducationInformations < ActiveRecord::Migration[6.0]
  def change
    create_table :education_informations do |t|
      t.integer :activity
      t.string :advisor
      t.integer :advisor_id_number
      t.references :country, foreign_key: true
      t.string :department
      t.string :diploma_equivalency
      t.string :diploma_no
      t.string :discipline
      t.integer :end_year
      t.integer :end_date_of_thesis
      t.string :faculty
      t.datetime :last_update
      t.integer :location
      t.string :other_discipline
      t.string :other_university
      t.integer :program
      t.integer :start_year
      t.integer :start_date_of_thesis
      t.string :thesis_name
      t.integer :thesis_step
      t.references :user, null: false, foreign_key: true
      t.integer :unit_id
      t.string :university
      t.integer :yoksis_id
      t.timestamps
    end

    add_null_constraint :education_informations, :location
    add_null_constraint :education_informations, :program
    add_null_constraint :education_informations, :yoksis_id
    add_null_constraint :education_informations, :start_year

    add_length_constraint :education_informations, :advisor, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :department, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :diploma_equivalency, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :diploma_no, less_than_or_equal_to: 100
    add_length_constraint :education_informations, :discipline, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :faculty, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :other_discipline, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :other_university, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :thesis_name, less_than_or_equal_to: 255
    add_length_constraint :education_informations, :university, less_than_or_equal_to: 255

    add_numericality_constraint :education_informations, :activity, greater_than_or_equal_to: 0
    add_numericality_constraint :education_informations, :advisor_id_number, equal_to: 11
    add_numericality_constraint :education_informations, :end_date_of_thesis, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
    add_numericality_constraint :education_informations, :end_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
    add_numericality_constraint :education_informations, :location, greater_than_or_equal_to: 0
    add_numericality_constraint :education_informations, :program, greater_than_or_equal_to: 0
    add_numericality_constraint :education_informations, :start_date_of_thesis, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
    add_numericality_constraint :education_informations, :start_year, greater_than_or_equal_to: 1950, less_than_or_equal_to: 2050
    add_numericality_constraint :education_informations, :thesis_step, greater_than_or_equal_to: 0
    add_numericality_constraint :education_informations, :unit_id, greater_than_or_equal_to: 0
    add_numericality_constraint :education_informations, :yoksis_id, greater_than_or_equal_to: 0
  end
end
