# frozen_string_literal: true

class AddSemesterAndYearToStudents < ActiveRecord::Migration[6.0]
  def change
    add_column :students, :semester, :integer
    add_column :students, :year, :integer

    add_null_constraint :students, :semester
    add_null_constraint :students, :year

    add_numericality_constraint :students, :semester, greater_than: 0
    add_numericality_constraint :students, :year, greater_than_or_equal_to: 0
  end
end
