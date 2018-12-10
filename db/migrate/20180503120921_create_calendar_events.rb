# frozen_string_literal: true

class CreateCalendarEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_events do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.references :academic_calendar,
                   null: false,
                   foreign_key: true
      t.references :calendar_title,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :calendar_events, :start_date
  end
end
