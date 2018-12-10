# frozen_string_literal: true

class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string :name
      t.string :mernis_code
      t.boolean :active, default: true
      t.references :city,
                   null: false,
                   foreign_key: true
    end

    add_presence_constraint :districts, :name
    add_presence_constraint :districts, :active

    add_length_constraint :districts, :name, less_than_or_equal_to: 255
    add_length_constraint :districts, :mernis_code, equal_to: 4
  end
end
