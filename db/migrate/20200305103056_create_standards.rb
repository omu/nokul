# frozen_string_literal: true

class CreateStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :standards do |t|
      t.string :version
      t.string :name

      t.timestamps null: false
    end

    add_length_constraint :standards, :version, less_than_or_equal_to: 50
    add_length_constraint :standards, :name, less_than_or_equal_to: 255

    add_presence_constraint :standards, :version
    add_presence_constraint :standards, :name

    add_unique_constraint :standards, [:version, :name]
  end
end
