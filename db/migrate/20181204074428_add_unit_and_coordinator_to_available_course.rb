# frozen_string_literal: true

class AddUnitAndCoordinatorToAvailableCourse < ActiveRecord::Migration[5.2]
  def change
    add_reference :available_courses, :unit, foreign_key: true
    add_reference :available_courses, :coordinator, foreign_key: { to_table: :employees }
    add_column :available_courses, :groups_count, :integer, default: 0
  end
end
