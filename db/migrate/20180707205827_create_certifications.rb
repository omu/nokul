# frozen_string_literal: true

class CreateCertifications < ActiveRecord::Migration[5.2]
  def change
    create_table :certifications do |t|
      t.integer :yoksis_id
      t.integer :type
      t.string :name
      t.string :content
      t.string :location
      t.integer :scope
      t.string :duration
      t.date :start_date
      t.date :end_date
      t.string :title
      t.integer :number_of_authors
      t.string :city_and_country
      t.datetime :last_update
      t.float :incentive_point, default: 0
      t.integer :status
      t.references :user,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_null_constraint :certifications, :yoksis_id
    add_null_constraint :certifications, :type
    add_null_constraint :certifications, :title

    add_length_constraint :certifications, :name, less_than_or_equal_to: 255
    add_length_constraint :certifications, :content, less_than_or_equal_to: 65_535
    add_length_constraint :certifications, :location, less_than_or_equal_to: 255
    add_length_constraint :certifications, :duration, less_than_or_equal_to: 255
    add_length_constraint :certifications, :title, less_than_or_equal_to: 255
    add_length_constraint :certifications, :city_and_country, less_than_or_equal_to: 255

    add_numericality_constraint :certifications, :yoksis_id,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :certifications, :type,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :certifications, :scope,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :certifications, :number_of_authors,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :certifications, :status,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :certifications, :incentive_point,
                                greater_than_or_equal_to: 0
  end
end
