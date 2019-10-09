class CreateBuildings < ActiveRecord::Migration[6.0]
  def change
    create_table :buildings do |t|
      t.integer :meksis_id
      t.string :name
      t.string :code
      t.float :indoor_area
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :active
      t.references :place_type, null: false, foreign_key: true
      t.references :unit, null: false, foreign_key: true

      t.timestamps
    end

    add_presence_constraint :buildings, :name
    add_presence_constraint :buildings, :code

    add_null_constraint :buildings, :meksis_id

    add_length_constraint :buildings, :name, less_than_or_equal_to: 255
    add_length_constraint :buildings, :code, less_than_or_equal_to: 255

    add_numericality_constraint :buildings, :meksis_id, greater_than_or_equal_to: 1

    add_unique_constraint :buildings, :name
    add_unique_constraint :buildings, :code
    add_unique_constraint :buildings, :meksis_id
    add_unique_constraint :buildings, :latitude
    add_unique_constraint :buildings, :longitude
  end
end
