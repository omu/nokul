# frozen_string_literal: true

class CreateStudentGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :student_grades do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :student_grades, :name
    add_presence_constraint :student_grades, :code

    add_length_constraint :student_grades, :name, less_than_or_equal_to: 255

    add_numericality_constraint :student_grades, :code,
                                greater_than_or_equal_to: 0
  end
end
