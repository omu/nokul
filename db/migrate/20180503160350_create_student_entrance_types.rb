# frozen_string_literal: true

class CreateStudentEntranceTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_entrance_types do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :student_entrance_types, :name
    add_null_constraint :student_entrance_types, :code

    add_length_constraint :student_entrance_types, :name,
                          less_than_or_equal_to: 255

    add_numericality_constraint :student_entrance_types, :code,
                                greater_than_or_equal_to: 0

    add_unique_constraint :student_entrance_types, :name
    add_unique_constraint :student_entrance_types, :code
  end
end
