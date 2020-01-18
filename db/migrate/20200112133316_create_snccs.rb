class CreateSnccs < ActiveRecord::Migration[6.0]
  def change
    create_table :snccs do |t|
      t.integer :institution_id,  null:false
      t.integer :standard_id,     null:false
      t.string :code,             null:false, limit: 10
      t.string :name_tr,          null:false, limit: 255
      t.string :name_en,          null:false, limit: 255

      t.timestamps null: false
    end
  end

  add_index :snccs, [:institution_id, :code], unique: true
end
