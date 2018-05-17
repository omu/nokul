class CreateAcademicCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_calendars do |t|
      t.string :name, null: false
      t.references :academic_term, foreign_key: true
      t.references :calendar_type, foreign_key: true
      t.date :senate_decision_date, null: false
      t.string :senate_decision_no, null: false
      t.text :description
      t.timestamps
    end
  end
end
