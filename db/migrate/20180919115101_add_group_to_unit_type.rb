class AddGroupToUnitType < ActiveRecord::Migration[5.2]
  def change
    add_column :unit_types, :group, :integer
  end
end
