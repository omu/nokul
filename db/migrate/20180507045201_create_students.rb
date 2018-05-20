class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.string :student_number, unique: true, null: false
      t.belongs_to :user, foreign_key: true
      t.belongs_to :unit, foreign_key: true
      t.timestamps
    end
  end
end
