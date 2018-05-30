class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.references :duty, foreign_key: true
      t.references :administrative_function, foreign_key: true
      t.timestamps
    end
  end
end
