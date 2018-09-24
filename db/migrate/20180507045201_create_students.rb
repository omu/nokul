# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :student_number, null: false, limit: 255
      t.references :user
      t.references :unit
      t.timestamps
    end
  end
end
