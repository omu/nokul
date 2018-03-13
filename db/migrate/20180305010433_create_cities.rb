class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name, unique: true
      t.string :iso, unique: true
      t.string :nuts_code, unique: true
      t.belongs_to :region, foreign_key: true
      t.belongs_to :country, foreign_key: true
    end
  end
end
