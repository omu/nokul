class CreateStudentGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :student_grades do |t|
      t.string :name
      t.integer :code
    end
  end
end
