# frozen_string_literal: true

class CreateRegistrationDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_documents do |t|
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :document,
                   null: false,
                   foreign_key: true
      t.references :academic_term,
                   null: false,
                   foreign_key: true
      t.timestamps
    end
  end
end
