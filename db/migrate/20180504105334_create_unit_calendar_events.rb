class CreateUnitCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_calendar_events do |t|
      t.references :academic_calendar, foreign_key: true
      t.references :unit, foreign_key: true
      t.references :calendar_title, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.timestamps
    end
  end
end
