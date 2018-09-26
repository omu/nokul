# frozen_string_literal: true

class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :name, null: false, limit: 255
      t.integer :yoksis_id
      t.integer :detsis_id
      t.integer :foet_code
      t.date :founded_at
      t.integer :duration, limit: 1
      t.integer :osym_id
      t.string :ancestry, index: true
      t.references :district
      t.references :unit_status
      t.references :unit_instruction_language
      t.references :unit_instruction_type
      t.references :university_type
      t.references :unit_type
      t.timestamps
    end
  end
end
