class AddMissingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :units, :unit_status_id
    add_index :units, :unit_type_id
    add_index :units, :unit_instruction_language_id
    add_index :units, :unit_instruction_type_id
  end
end
