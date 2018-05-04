class CreateStudentEntrancePointTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_entrance_point_types do |t|
      t.string :name
      t.integer :code
    end
  end
end
