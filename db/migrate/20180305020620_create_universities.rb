class CreateUniversities < ActiveRecord::Migration[5.1]
  def change
    create_table :universities do |t|
      t.string :name
      t.string :short_name
      t.integer :type
      t.integer :yoksis_id
      t.boolean :active, default: true
      t.belongs_to :city, foreign_key: true
      t.timestamps
    end
  end
end
