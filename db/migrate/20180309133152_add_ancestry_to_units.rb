class AddAncestryToUnits < ActiveRecord::Migration[5.1]
  def change
    add_column :units, :ancestry, :string
    add_index :units, :ancestry
  end
end
