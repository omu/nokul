class ChangeYoksisIdAndDetsisIdConstraintToUnit < ActiveRecord::Migration[5.2]
  def change
    change_column :units, :yoksis_id, :integer, null: true
    change_column :units, :detsis_id, :integer, unique: true, null: true
  end
end
