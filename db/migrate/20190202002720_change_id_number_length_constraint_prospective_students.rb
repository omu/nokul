# frozen_string_literal: true

class ChangeIdNumberLengthConstraintProspectiveStudents < ActiveRecord::Migration[6.0]
  def change
    remove_length_constraint :prospective_students, :id_number
    add_length_constraint :prospective_students, :id_number,
                          greater_than_or_equal_to: 5,
                          less_than_or_equal_to: 11
  end
end
