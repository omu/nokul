# frozen_string_literal: true

class CreateAcademicTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_terms do |t|
      t.string :year
      t.integer :term
    end

    add_presence_constraint :academic_terms, :year
    add_presence_constraint :academic_terms, :term

    add_length_constraint :academic_terms, :year, less_than_or_equal_to: 255
  end
end
