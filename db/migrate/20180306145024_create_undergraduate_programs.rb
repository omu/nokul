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
      t.references :program, polymorphic: true, index: true
      t.timestamps
    end
  end
end
