# frozen_string_literal: true

class DropUnitCalendarEvent < ActiveRecord::Migration[5.2]
  def change
    drop_table :unit_calendar_events
  end
end
