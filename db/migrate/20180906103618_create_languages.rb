class CreateLanguages < ActiveRecord::Migration[5.2]
  def change
    create_table :languages do |t|
      t.string :name, null: false, unique: true
      t.string :iso, null: false, unique: true
      t.integer :yoksis_code

      t.timestamps
    end
  end
end
