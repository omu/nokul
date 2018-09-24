# frozen_string_literal: true

class CreateStudentEducationLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :student_education_levels do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
