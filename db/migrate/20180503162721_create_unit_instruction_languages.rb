class CreateUnitInstructionLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_instruction_languages do |t|
      t.string :name
      t.integer :code
    end
  end
end
