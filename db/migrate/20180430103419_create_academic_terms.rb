class CreateAcademicTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_terms do |t|
      t.string :year, null: false
      t.integer :term, null: false
      t.timestamps
    end
  end
end
