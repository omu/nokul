# frozen_string_literal: true

class CreateStudentStudentshipStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :student_studentship_statuses do |t|
      t.string :name
      t.integer :code
    end

    add_presence_constraint :student_studentship_statuses, :name
    add_null_constraint :student_studentship_statuses, :code

    add_length_constraint :student_studentship_statuses, :name,
                                                         less_than_or_equal_to: 255

    add_numericality_constraint :student_studentship_statuses, :code,
                                greater_than_or_equal_to: 0

    add_unique_constraint :student_studentship_statuses, :name
    add_unique_constraint :student_studentship_statuses, :code
  end
end
