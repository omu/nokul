class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name, unique: true, null: false
      t.string :iso, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
