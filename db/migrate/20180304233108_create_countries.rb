class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name, unique: true
      t.string :iso, unique: true
      t.integer :code, unique: true
    end
  end
end
