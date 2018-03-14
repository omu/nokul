class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.string :name, unique: true, null: false
      t.string :short_name, unique: true, null: false
      t.integer :university_type, default: 0
      t.integer :yoksis_id, unique: true, null: false
      t.integer :status, default: 0
      t.date :founded_at
      t.belongs_to :city, foreign_key: true
    end
  end
end
