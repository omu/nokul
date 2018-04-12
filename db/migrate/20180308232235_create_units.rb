class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.integer :yoksis_id, unique: true, null: false
      t.integer :status, default: 1, null: false
      t.date :founded_at
      t.integer :instruction_type, default: 1, null: false
      t.integer :foet_code
      t.string :language
      t.integer :duration
      t.string :type, null: false # STI field
      t.belongs_to :city, foreign_key: true
      t.timestamps
    end
  end
end
