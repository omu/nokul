class AddNotNullConstraintToUnitTypes < ActiveRecord::Migration[5.2]
  def change
    change_column_null :unit_types, :name, false
    change_column_null :unit_types, :code, false
  end
end
