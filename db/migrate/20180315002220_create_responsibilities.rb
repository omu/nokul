class CreateResponsibilities < ActiveRecord::Migration[5.1]
  def change
    create_table :responsibilities do |t|
      t.belongs_to :unit, foreign_key: true
      t.belongs_to :position, foreign_key: true
      t.timestamps
    end
  end
end
