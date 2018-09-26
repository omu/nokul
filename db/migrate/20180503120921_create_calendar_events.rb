# frozen_string_literal: true

class CreateCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_events do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.references :academic_calendar
      t.references :calendar_title
      t.timestamps
    end
  end
end
