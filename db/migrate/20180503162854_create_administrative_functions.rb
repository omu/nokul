# frozen_string_literal: true

class CreateAdministrativeFunctions < ActiveRecord::Migration[5.2]
  def change
    create_table :administrative_functions do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :administrative_functions, :name
    add_null_constraint :administrative_functions, :code

    add_length_constraint :administrative_functions, :name, less_than_or_equal_to: 255

    add_numericality_constraint :administrative_functions, :code,
                                greater_than_or_equal_to: 0

    add_unique_constraint :administrative_functions, :name
    add_unique_constraint :administrative_functions, :code
  end
end
