# frozen_string_literal: true

class CreateStudentDisabilityTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_disability_types do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
