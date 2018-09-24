class CreateCurriculums < ActiveRecord::Migration[5.2]
  def change
    create_table :curriculums do |t|
      t.string :name
      t.references :unit, foreign_key: true
      t.integer :number_of_semesters
      t.integer :status, null: false
    end
  end
end
