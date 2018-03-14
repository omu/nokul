class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name, unique: true, null: false
      t.string :iso, unique: true, null: false
      t.string :nuts_code, unique: true, null: false
      t.belongs_to :region, foreign_key: true
      t.belongs_to :country, foreign_key: true
    end
  end
end
