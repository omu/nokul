class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :name
      t.integer :yoksis_id, unique: true
      t.integer :status, default: 0
      t.date :founded_at
      t.string :type # STI field
      t.belongs_to :university, foreign_key: true
      t.timestamps
    end
  end
end
