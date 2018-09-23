# frozen_string_literal: true

class CreateStudentStudentshipStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :student_studentship_statuses do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
