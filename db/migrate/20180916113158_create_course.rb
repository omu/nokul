class CreateCourse < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :name, null: false 
      t.string :code, null: false
      t.integer :theoric, null: false
      t.integer :practice, null: false
      t.integer :laboratory, null: false
      t.decimal :credit, precision: 5, scale: 2, default: 0, null: false
      t.references :unit, foreign_key: true
      t.integer :program_type, null: false
      t.references :language, foreign_key: true
      t.integer :status, null: false
      t.timestamps
    end
  end
end
