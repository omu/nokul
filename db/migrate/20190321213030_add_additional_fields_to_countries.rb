# frozen_string_literal: true

class AddAdditionalFieldsToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :continent, :string
    add_column :countries, :region, :string
    add_column :countries, :subregion, :string
    add_column :countries, :world_region, :string
    add_column :countries, :phone_code, :string
    add_column :countries, :latitude, :float, default: 0
    add_column :countries, :longitude, :float, default: 0
    add_column :countries, :currency_code, :string
    add_column :countries, :start_of_week, :string
    add_column :countries, :un_locode, :string

    execute "UPDATE countries SET continent = 'Unknown' WHERE continent IS NULL"
    execute "UPDATE countries SET world_region = 'Unknown' WHERE world_region IS NULL"
    execute "UPDATE countries SET latitude = 0 WHERE latitude IS NULL"
    execute "UPDATE countries SET longitude = 0 WHERE longitude IS NULL"
    execute "UPDATE countries SET currency_code = 'Unk' WHERE currency_code IS NULL"

    add_presence_constraint :countries, :continent
    add_length_constraint :countries, :continent, less_than_or_equal_to: 255
    add_length_constraint :countries, :region, less_than_or_equal_to: 255
    add_length_constraint :countries, :subregion, less_than_or_equal_to: 255
    add_presence_constraint :countries, :world_region
    add_length_constraint :countries, :world_region, less_than_or_equal_to: 255
    add_length_constraint :countries, :phone_code, less_than_or_equal_to: 3
    add_null_constraint :countries, :latitude
    add_null_constraint :countries, :longitude
    add_presence_constraint :countries, :currency_code
    add_length_constraint :countries, :currency_code, equal_to: 3
    add_length_constraint :countries, :start_of_week, less_than_or_equal_to: 255
    add_length_constraint :countries, :un_locode, equal_to: 2
  end
end
