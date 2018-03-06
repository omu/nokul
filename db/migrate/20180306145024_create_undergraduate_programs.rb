class CreateUndergraduatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :undergraduate_programs do |t|
      t.string :name
      t.integer :yoksis_id
      t.boolean :active
      t.string :language_code
      t.date :founded_at
      t.integer :program_type
      t.integer :duration
      t.integer :program_id, foreign_key: true
      t.string :program_type
      t.timestamps
    end
  end
end
