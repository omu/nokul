class CreateAdministrativeFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :administrative_functions do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
