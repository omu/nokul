class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.belongs_to :title, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
