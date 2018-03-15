class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.string :name, unique: true, null: false
      t.integer :yoksis_id, unique: true, null: false
    end
  end
end
