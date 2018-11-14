# frozen_string_literal: true

class AddStartTermAndEndTermToAcademicTerm < ActiveRecord::Migration[5.2]
  def change
    add_column :academic_terms, :start_of_term, :datetime
    add_column :academic_terms, :end_of_term, :datetime
    add_column :academic_terms, :active, :boolean, default: false
  end
end
