class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :iso
      t.string :nuts_code
      t.belongs_to :region, foreign_key: true
      t.belongs_to :country, foreign_key: true
      t.timestamps
    end
  end
end
