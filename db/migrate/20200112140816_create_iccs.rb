# frozen_string_literal: true

class CreateIccs < ActiveRecord::Migration[6.0]
  def change
    create_table :iccs do |t|
      t.integer :unit_id
      t.integer :sncc_id
      t.string :code
      t.string :name_tr
      t.string :name_en

      t.timestamps
    end

    add_index :iccs, :unit_id
    add_index :iccs, :sncc_id
    add_index :iccs, :code

    add_length_constraint :iccs, :unit_id, greater_than_or_equal_to: 0
    add_length_constraint :iccs, :sncc_id, greater_than_or_equal_to: 0
    add_length_constraint :iccs, :code, less_than_or_equal_to: 255
    add_length_constraint :iccs, :name_tr, less_than_or_equal_to: 255
    add_length_constraint :iccs, :name_en, less_than_or_equal_to: 255

    add_numericality_constraint :iccs, :unit_id,
                                greater_than_or_equal_to: 0
    add_numericality_constraint :iccs, :sncc_id,
                                greater_than_or_equal_to: 0

    add_presence_constraint :iccs, :unit_id
    add_presence_constraint :iccs, :sncc_id
    add_presence_constraint :iccs, :code
    add_presence_constraint :iccs, :name_tr
    add_presence_constraint :iccs, :name_en

    add_unique_constraint :iccs, [:unit_id, :sncc_id, :code]
  end
end
