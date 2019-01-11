# frozen_string_literal: true

class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :name
      t.string :abbreviation
      t.string :code
      t.integer :yoksis_id
      t.integer :detsis_id
      t.integer :osym_id
      t.integer :foet_code
      t.date :founded_at
      t.integer :duration
      t.string :ancestry, index: true
      t.string :names_depth_cache
      t.references :district,
                   null: false,
                   foreign_key: true
      t.references :unit_status,
                   null: false,
                   foreign_key: true
      t.references :unit_instruction_language,
                   foreign_key: true
      t.references :unit_instruction_type,
                   foreign_key: true
      t.references :university_type,
                   foreign_key: true
      t.references :unit_type,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :units, :name

    add_length_constraint :units, :name, less_than_or_equal_to: 255
    add_length_constraint :units, :abbreviation, less_than_or_equal_to: 255
    add_length_constraint :units, :code, less_than_or_equal_to: 255
    add_length_constraint :units, :names_depth_cache, less_than_or_equal_to: 255

    add_numericality_constraint :units, :yoksis_id,
                                greater_than_or_equal_to: 1
    add_numericality_constraint :units, :detsis_id,
                                greater_than_or_equal_to: 1
    add_numericality_constraint :units, :osym_id,
                                greater_than_or_equal_to: 1
    add_numericality_constraint :units, :foet_code,
                                greater_than_or_equal_to: 1
    add_numericality_constraint :units, :duration,
                                greater_than_or_equal_to: 1,
                                less_than_or_equal_to: 8
  end
end
