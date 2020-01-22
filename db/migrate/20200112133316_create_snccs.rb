# frozen_string_literal: true

class CreateSnccs < ActiveRecord::Migration[6.0]
  def change
    create_table :snccs do |t|
      t.integer :unit_id
      t.integer :standard_id
      t.string :code
      t.string :name_tr
      t.string :name_en

      t.timestamps null: false
    end

    add_length_constraint :snccs, :unit_id, greater_than_or_equal_to: 0
    add_length_constraint :snccs, :standard_id, greater_than_or_equal_to: 0
    add_length_constraint :snccs, :code, less_than_or_equal_to: 10
    add_length_constraint :snccs, :name_tr, less_than_or_equal_to: 255
    add_length_constraint :snccs, :name_en, less_than_or_equal_to: 255

    add_presence_constraint :snccs, :code
    add_presence_constraint :snccs, :name_tr
    add_presence_constraint :snccs, :name_en

    add_unique_constraint :snccs, [:unit_id, :code]
  end
end
