# frozen_string_literal: true

class CreateAcademicTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_terms do |t|
      t.string :year
      t.integer :term
      t.datetime :start_of_term
      t.datetime :end_of_term
      t.boolean :active, default: false
    end

    add_presence_constraint :academic_terms, :year
    add_null_constraint :academic_terms, :term
    add_null_constraint :academic_terms, :active

    add_length_constraint :academic_terms, :year, less_than_or_equal_to: 255

    add_numericality_constraint :academic_terms, :term,
                                greater_than_or_equal_to: 0
  end
end
