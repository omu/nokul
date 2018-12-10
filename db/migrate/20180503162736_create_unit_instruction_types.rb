# frozen_string_literal: true

class CreateUnitInstructionTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_instruction_types do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :unit_instruction_types, :name
    add_null_constraint :unit_instruction_types, :code

    add_length_constraint :unit_instruction_types, :name, less_than_or_equal_to: 255

    add_numericality_constraint :unit_instruction_types, :code,
                                greater_than_or_equal_to: 0
  end
end
