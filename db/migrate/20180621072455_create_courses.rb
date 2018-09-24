# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name, null: false, limit: 255
      t.string :code, null: false, limit: 255
      t.integer :theoric, null: false
      t.integer :practice, null: false
      t.integer :laboratory, null: false
      t.decimal :credit, precision: 5, scale: 2, default: 0, null: false
      t.integer :program_type, null: false
      t.integer :status, null: false
      t.references :unit
      t.timestamps
    end
  end
end
