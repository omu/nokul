# frozen_string_literal: true

class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.integer :yoksis_id, unique: true, null: false
      t.integer :detsis_id
      t.integer :foet_code
      t.date :founded_at
      t.integer :duration
      t.string :ancestry, index: true
      t.references :district, foreign_key: true
      t.references :unit_status, foreign_key: true
      t.references :unit_instruction_language, foreign_key: true
      t.references :unit_instruction_type, foreign_key: true
      t.references :university_type, foreign_key: true
      t.references :unit_type, foreign_key: true
      t.timestamps
    end
  end
end
