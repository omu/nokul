# frozen_string_literal: true

class AddDisabilityToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :disability_type, foreign_key: { to_table: 'student_disability_types' }
    add_column :users, :disability_rate, :integer, default: 0

    add_numericality_constraint :users, :disability_rate, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
  end
end
