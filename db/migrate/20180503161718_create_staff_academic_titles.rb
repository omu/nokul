class CreateStaffAcademicTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :staff_academician_titles do |t|
      t.string :name
      t.integer :code
    end
  end
end
