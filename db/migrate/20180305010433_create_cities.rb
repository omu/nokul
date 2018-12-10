# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :alpha_2_code
      t.references :country,
                   null: false,
                   foreign_key: true
    end

    add_presence_constraint :cities, :name
    add_presence_constraint :cities, :alpha_2_code

    add_length_constraint :cities, :name, less_than_or_equal_to: 255
    add_length_constraint :cities, :alpha_2_code, less_than_or_equal_to: 255
  end
end
