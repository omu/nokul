class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :identifier
      t.text :description

      t.timestamps
    end

    add_index :permissions, :name, unique: true

    add_presence_constraint :permissions, :name
    add_presence_constraint :permissions, :identifier

    add_length_constraint :permissions, :name,        less_than_or_equal_to: 255
    add_length_constraint :permissions, :identifier,  less_than_or_equal_to: 255
    add_length_constraint :permissions, :description, less_than_or_equal_to: 65_535
  end
end
