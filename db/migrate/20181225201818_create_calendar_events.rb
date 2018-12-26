# frozen_string_literal: true

class CreateCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_events do |t|
      t.references :calendar,
                   foreign_key: true,
                   null: false
      t.references :calendar_event_type,
                   foreign_key: true,
                   null: false
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.string :timezone, default: 'Istanbul'
      t.boolean :visible, default: true
      t.timestamps
    end

    add_presence_constraint :calendar_events, :timezone
    add_null_constraint :calendar_events, :visible

    add_length_constraint :calendar_events, :location, less_than_or_equal_to: 255
    add_length_constraint :calendar_events, :timezone, less_than_or_equal_to: 255
  end
end
