class AddYoksisCodeToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :yoksis_code, :integer
  end
end
