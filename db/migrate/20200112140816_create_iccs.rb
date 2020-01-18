class CreateIccs < ActiveRecord::Migration[6.0]
  def change
    create_table :iccs do |t|
      t.integer :institution_id,  null:false
      t.integer :sncc_id,         null:false
      t.string :code,             null:false, limit: 255
      t.string :name_tr,          null:false, limit: 255
      t.string :name_en,          null:false, limit: 255

      t.timestamps
    end
  end

  add_index :iccs, [:institution_id, :sncc_id, :code], unique: true
  add_index :iccs, :institution_id
  add_index :iccs, :sncc_id
  add_index :iccs, :code
end
