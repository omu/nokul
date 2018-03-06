class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :yoksis_id
      t.boolean :active
      t.string :language_code
      t.date :founded_at
      t.integer :unit_id, foreign_key: true
      t.string :unity_type
      t.timestamps
    end
  end
end
