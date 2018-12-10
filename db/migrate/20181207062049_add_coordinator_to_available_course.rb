# frozen_string_literal: true

class AddCoordinatorToAvailableCourse < ActiveRecord::Migration[5.2]
  def change
    add_reference :available_courses, :coordinator, foreign_key: { to_table: :employees }
  end
end
