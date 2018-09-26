# frozen_string_literal: true

class AddStudentEntranceTypeToProspectiveStudents < ActiveRecord::Migration[5.2]
  def change
    add_reference :prospective_students, :student_entrance_type, index: true
  end
end
