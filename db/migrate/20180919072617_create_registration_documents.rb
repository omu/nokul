# frozen_string_literal: true

class CreateRegistrationDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_documents do |t|
      t.references :unit
      t.references :document
      t.references :academic_term
      t.timestamps
    end
  end
end
