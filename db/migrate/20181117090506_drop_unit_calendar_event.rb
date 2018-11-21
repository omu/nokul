# frozen_string_literal: true

class DropUnitCalendarEvent < ActiveRecord::Migration[5.2]
  def change
    drop_table :unit_calendar_events do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.references :academic_calendar
      t.references :unit
      t.references :calendar_title
      t.timestamps
    end
  end
end
