class CreatePlaceTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :place_types do |t|
      t.integer :meksis_id
      t.string :name
      t.string :ancestry

      t.timestamps
    end

    add_index :place_types, :ancestry

    add_presence_constraint :place_types, :name
    add_null_constraint :place_types, :meksis_id

    add_unique_constraint :place_types, :name
    add_unique_constraint :place_types, :meksis_id
  end
end
