# frozen_string_literal: true

class CreateStudentDisabilityTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_disability_types do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :student_disability_types, :name
    add_null_constraint :student_disability_types, :code

    add_length_constraint :student_disability_types, :name,
                                                     less_than_or_equal_to: 255

    add_numericality_constraint :student_disability_types, :code,
                                greater_than_or_equal_to: 0
  end
end
