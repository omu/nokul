class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :name, unique: true
      t.string :nuts_code, unique: true
      t.belongs_to :country, foreign_key: true
    end
  end
end
