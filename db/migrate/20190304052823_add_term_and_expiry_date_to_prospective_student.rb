# frozen_string_literal: true

class AddTermAndExpiryDateToProspectiveStudent < ActiveRecord::Migration[6.0]
  def change
    add_reference :prospective_students, :academic_term, foreign_key: true
    add_column :prospective_students, :expiry_date, :datetime
  end
end
