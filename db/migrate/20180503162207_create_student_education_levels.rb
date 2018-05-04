class CreateStudentEducationLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :student_education_levels do |t|
      t.string :name
      t.integer :code
    end
  end
end
