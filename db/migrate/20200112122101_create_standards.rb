# frozen_string_literal: true

class CreateStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :standards do |t|
      t.string :version
      t.string :name_tr
      t.string :name_en

      t.timestamps null: false
    end

    add_index :standards, :version
    add_index :standards, :name_tr
    add_index :standards, :name_en

    add_length_constraint :standards, :version, less_than_or_equal_to: 50
    add_length_constraint :standards, :name_tr, less_than_or_equal_to: 255
    add_length_constraint :standards, :name_en, less_than_or_equal_to: 255

    add_presence_constraint :standards, :version
    add_presence_constraint :standards, :name_tr
    add_presence_constraint :standards, :name_en

    add_unique_constraint :standards, [:version, :name_tr]
    add_unique_constraint :standards, [:version, :name_en]
  end
end
