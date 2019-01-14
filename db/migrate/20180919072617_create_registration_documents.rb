# frozen_string_literal: true

class CreateRegistrationDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_documents do |t|
      t.references :unit,
                   null: false,
                   foreign_key: true
      t.references :document_type,
                   null: false,
                   foreign_key: true
      t.references :academic_term,
                   null: false,
                   foreign_key: true
      t.string :description
      t.timestamps
    end

    add_length_constraint :registration_documents, :description, less_than_or_equal_to: 65535
  end
end
