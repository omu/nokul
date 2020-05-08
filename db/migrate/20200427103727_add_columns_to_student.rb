# frozen_string_literal: true

class AddColumnsToStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :entrance_type, foreign_key: { to_table: :student_entrance_types }
    add_column :students, :other_studentship, :boolean, default: false
    add_column :students, :preparatory_class, :integer, default: 0
    add_column :students, :registration_date, :datetime
    add_reference :students, :registration_term, foreign_key: { to_table: :academic_terms }

    add_null_constraint :students, :other_studentship
    add_numericality_constraint :students, :preparatory_class, greater_than_or_equal_to: 0
  end
end
