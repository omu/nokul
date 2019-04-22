class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :identifier
      t.boolean :locked, default: false

      t.timestamps
    end

    add_index :roles, :name, unique: true
    add_index :roles, :identifier, unique: true

    add_presence_constraint :roles, :name
    add_presence_constraint :roles, :identifier

    add_length_constraint :roles, :name,        less_than_or_equal_to: 255
    add_length_constraint :roles, :identifier,  less_than_or_equal_to: 255

    add_null_constraint :roles, :locked
  end
end
