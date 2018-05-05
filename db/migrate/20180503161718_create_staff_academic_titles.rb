class CreateStaffAcademicTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_academic_titles do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
