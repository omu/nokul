# frozen_string_literal: true

class CreateStudentEntrancePointTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_entrance_point_types do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :student_entrance_point_types, :name
    add_presence_constraint :student_entrance_point_types, :code

    add_length_constraint :student_entrance_point_types, :name,
                                                         less_than_or_equal_to: 255

    add_numericality_constraint :student_entrance_point_types, :code,
                                greater_than_or_equal_to: 0
  end
end
