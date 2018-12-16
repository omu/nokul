# frozen_string_literal: true

class CreateStudentEducationLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :student_education_levels do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :student_education_levels, :name
    add_null_constraint :student_education_levels, :code

    add_length_constraint :student_education_levels, :name,
                          less_than_or_equal_to: 255

    add_numericality_constraint :student_education_levels, :code,
                                greater_than_or_equal_to: 0

    add_unique_constraint :student_education_levels, :name
    add_unique_constraint :student_education_levels, :code
  end
end
