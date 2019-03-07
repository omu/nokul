# frozen_string_literal: true

class AddTermAndExpiryDateToProspectiveStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :prospective_students, :academic_term, foreign_key: true
    add_column :prospective_students, :expiry_date, :datetime
    add_column :prospective_students, :system_register_type, :integer, default: 0
    add_column :prospective_students, :archived, :boolean, default: false

    add_numericality_constraint :prospective_students, :system_register_type, greater_than_or_equal_to: 0
  end
end
