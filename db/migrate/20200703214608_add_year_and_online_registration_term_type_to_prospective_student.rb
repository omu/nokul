class AddYearAndOnlineRegistrationTermTypeToProspectiveStudent < ActiveRecord::Migration[6.0]
  def change
    add_column :prospective_students, :year, :integer
    add_column :prospective_students, :online_registration_term_type, :string

    add_length_constraint :prospective_students,
                          :online_registration_term_type,
                          less_than_or_equal_to: 10
    add_numericality_constraint :prospective_students,
                                :year,
                                greater_than_or_equal_to: 2010,
                                less_than_or_equal_to:    2100
  end
end
