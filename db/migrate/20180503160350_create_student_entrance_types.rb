# frozen_string_literal: true

class CreateStudentEntranceTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_entrance_types do |t|
      t.string :name, null: false, limit: 255
      t.integer :code, null: false
    end
  end
end
