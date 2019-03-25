# frozen_string_literal: true

class AddAdditionalFieldsToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :latitude, :float, default: 0
    add_column :cities, :longitude, :float, default: 0

    execute "UPDATE countries SET latitude = 0 WHERE latitude IS NULL"
    execute "UPDATE countries SET longitude = 0 WHERE longitude IS NULL"

    add_null_constraint :cities, :latitude
    add_null_constraint :cities, :longitude
  end
end
