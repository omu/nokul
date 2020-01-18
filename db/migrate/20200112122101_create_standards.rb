class CreateStandards < ActiveRecord::Migration[6.0]
  def change
    create_table :standards do |t|
      t.string :version,    null: false
      t.string :name_tr,    null: false, limit: 255
      t.string :name_en,    null: false, limit: 255

      t.timestamps null: false
    end
  end

  add_index :standards, :version, :unique :true
end
