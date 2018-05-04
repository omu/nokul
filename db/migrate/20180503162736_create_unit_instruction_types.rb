class CreateUnitInstructionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_instruction_types do |t|
      t.string :name
      t.integer :code
    end
  end
end
