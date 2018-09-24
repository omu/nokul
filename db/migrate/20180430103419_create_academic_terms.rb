# frozen_string_literal: true

class CreateAcademicTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_terms do |t|
      t.string :year, null: false, limit: 255
      t.integer :term, null: false, limit: 1
    end
  end
end
