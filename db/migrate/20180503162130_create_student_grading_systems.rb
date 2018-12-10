# frozen_string_literal: true

class CreateStudentGradingSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :student_grading_systems do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :student_grading_systems, :name
    add_presence_constraint :student_grading_systems, :code

    add_length_constraint :student_grading_systems, :name,
                                                    less_than_or_equal_to: 255

    add_numericality_constraint :student_grading_systems, :code,
                                greater_than_or_equal_to: 0
  end
end
