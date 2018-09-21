class AddOsymCodeToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :osym_id, :integer
  end
end
