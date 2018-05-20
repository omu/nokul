class CreateDuties < ActiveRecord::Migration[5.2]
  def change
    create_table :duties do |t|
      t.boolean :temporary
      t.date :start_date
      t.date :end_date
      t.belongs_to :employee, foreign_key: true
      t.belongs_to :unit, foreign_key: true
      t.timestamps
    end
  end
end
