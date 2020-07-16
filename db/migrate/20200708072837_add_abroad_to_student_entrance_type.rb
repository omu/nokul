# frozen_string_literal: true

class AddAbroadToStudentEntranceType < ActiveRecord::Migration[6.0]
  def change
    add_column :student_entrance_types, :abroad, :boolean, default: false

    add_null_constraint :student_entrance_types, :abroad
  end
end
