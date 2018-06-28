# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name, unique: true, null: false
      t.string :alpha_2_code, unique: true, null: false
      t.references :country, foreign_key: true
    end
  end
end
