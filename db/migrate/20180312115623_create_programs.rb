class CreatePrograms < ActiveRecord::Migration[5.1]
  def change
    create_table :programs do |t|
      t.string :name
      t.integer :yoksis_id
      t.integer :status, default: 0
      t.date :founded_at
      t.string :language
      t.integer :duration
      t.string :type # STI field
      t.belongs_to :unit, foreign_key: true
      t.timestamps
    end
  end
end
