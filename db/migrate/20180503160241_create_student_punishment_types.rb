class CreateStudentPunishmentTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :student_punishment_types do |t|
      t.string :name, unique: true, null: false
      t.integer :code, unique: true, null: false
    end
  end
end
