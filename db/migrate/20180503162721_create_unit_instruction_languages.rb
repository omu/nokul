# frozen_string_literal: true

class CreateUnitInstructionLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_instruction_languages do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :unit_instruction_languages, :name
    add_null_constraint :unit_instruction_languages, :code

    add_length_constraint :unit_instruction_languages, :name, less_than_or_equal_to: 255

    add_numericality_constraint :unit_instruction_languages, :code,
                                greater_than_or_equal_to: 0

    add_unique_constraint :unit_instruction_languages, :name
    add_unique_constraint :unit_instruction_languages, :code
  end
end
