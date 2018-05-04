class CreateStaffAdministrativeFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_administrative_functions do |t|
      t.string :name
      t.integer :code
    end
  end
end
