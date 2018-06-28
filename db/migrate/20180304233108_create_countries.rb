class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name, unique: true, null: false
      t.string :alpha_2_code, unique: true, null: false
      t.string :alpha_3_code, unique: true, null: false
      t.string :numeric_code, unique: true, null: false
      t.string :mernis_code
    end
  end
end
