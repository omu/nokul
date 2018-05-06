class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :mothers_name
      t.string :fathers_name
      t.integer :gender
      t.string :place_of_birth
      t.integer :marital_status
      t.date :date_of_birth
      t.string :registered_to
      t.datetime :updated_at, null: false
    end
  end
end
