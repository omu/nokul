class AddReferencesToUnits < ActiveRecord::Migration[5.2]
  def change
    add_column :units, :unit_status_id, :integer, foreign_key: true
    add_column :units, :unit_type_id, :integer, foreign_key: true
    add_column :units, :unit_instruction_language_id, :integer, foreign_key: true
    add_column :units, :unit_instruction_type_id, :integer, foreign_key: true
    add_column :units, :university_type_id, :integer
  end
end
