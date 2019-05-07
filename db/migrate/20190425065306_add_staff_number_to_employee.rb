# frozen_string_literal: true

class AddStaffNumberToEmployee < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :staff_number, :string

    add_length_constraint :employees, :staff_number, less_than_or_equal_to: 255
  end
end
