# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name, null: false, limit: 255
      t.string :alpha_2_code, null: false, limit: 255
      t.references :country
    end
  end
end
