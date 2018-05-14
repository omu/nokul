class CreateCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_events do |t|
      t.references :academic_calendar, foreign_key: true
      t.references :calendar_title, foreign_key: true
      t.datetime :start_date, null: false
      t.datetime :end_date

      t.timestamps
    end
    add_index :calendar_events, [:academic_calendar_id, :calendar_title_id],
                                unique: true, name: 'index_of_calendar_events'
  end
end
