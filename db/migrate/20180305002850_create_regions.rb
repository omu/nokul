class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string :name
      t.string :nuts_code
      t.belongs_to :country, foreign_key: true
      t.timestamps
    end
  end
end
