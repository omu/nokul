# frozen_string_literal: true

class CreateUnitCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_calendar_events do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date
      t.references :academic_calendar
      t.references :unit
      t.references :calendar_title
      t.timestamps
    end
  end
end
