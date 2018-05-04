class CreateStudentPunishmentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_punishment_types do |t|
      t.string :name
      t.integer :code
    end
  end
end
