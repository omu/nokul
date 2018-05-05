class CreateStudentDropOutTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_drop_out_types do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
