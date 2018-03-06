class CreateProficiencyInArtPrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :proficiency_in_art_programs do |t|
      t.string :name
      t.integer :yoksis_id
      t.boolean :active
      t.string :language_code
      t.date :founded_at
      t.integer :program_type
      t.integer :duration
      t.belongs_to :institute, foreign_key: true

      t.timestamps
    end
  end
end
