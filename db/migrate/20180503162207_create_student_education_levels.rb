class CreateStudentEducationLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :student_education_levels do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
