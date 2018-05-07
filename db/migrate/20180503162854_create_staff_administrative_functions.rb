class CreateStaffAdministrativeFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_administrative_functions do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
