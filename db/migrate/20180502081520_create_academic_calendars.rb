class CreateAcademicCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_calendars do |t|
      t.string :name
      t.integer :year
      t.references :academic_term, foreign_key: true
      t.references :calendar_type, foreign_key: true
      t.string :senatus_consultum_no

      t.timestamps
    end
  end
end
