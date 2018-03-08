class CreateVocationalSchools < ActiveRecord::Migration[5.1]
  def change
    create_table :vocational_schools do |t|
      t.string :name
      t.integer :yoksis_id
      t.integer :status, default: 0
      t.date :founded_at
      t.belongs_to :university, foreign_key: true
      t.timestamps
    end
  end
end
