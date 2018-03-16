class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :city, null: false
      t.integer :city_id, null: false
      t.string :district, null: false
      t.integer :district_id, null: false
      t.string :neighbourhood
      t.integer :neighbourhood_id
      t.text :full_address, null: false
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
