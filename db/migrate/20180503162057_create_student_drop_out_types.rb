class CreateStudentDropOutTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_drop_out_types do |t|
      t.string :name
      t.integer :code
    end
  end
end
