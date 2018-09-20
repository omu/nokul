class CreateRegistrationDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_documents do |t|
      t.references :unit, foreign_key: true
      t.references :document, foreign_key: true
      t.references :academic_term, foreign_key: true

      t.timestamps
    end
  end
end
