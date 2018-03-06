class CreateInstitutes < ActiveRecord::Migration[5.1]
  def change
    create_table :institutes do |t|
      t.string :name
      t.integer :yoksis_id
      t.boolean :active
      t.date :founded_at
      t.belongs_to :university, foreign_key: true
      t.timestamps
    end
  end
end
