# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :alpha_2_code
      t.string :alpha_3_code
      t.string :numeric_code
      t.string :mernis_code
      t.integer :yoksis_code
    end

    add_unique_constraint :countries, :name

    add_presence_constraint :countries, :name
    add_presence_constraint :countries, :alpha_2_code
    add_presence_constraint :countries, :alpha_3_code
    add_presence_constraint :countries, :numeric_code

    add_length_constraint :countries, :name, less_than_or_equal_to: 255
    add_length_constraint :countries, :alpha_2_code, equal_to: 2
    add_length_constraint :countries, :alpha_3_code, equal_to: 3
    add_length_constraint :countries, :numeric_code, equal_to: 3
    add_length_constraint :countries, :mernis_code, equal_to: 4

    add_numericality_constraint :countries, :yoksis_code,
                                greater_than_or_equal_to: 1
  end
end
