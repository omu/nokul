class CreateStudentStudentshipStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :student_studentship_statuses do |t|
      t.string :name
      t.integer :code
    end
  end
end
