# frozen_string_literal: true

class AddCalendarTypeAndTermToCalendarEvent < ActiveRecord::Migration[5.2]
  def change
    add_reference :calendar_events, :calendar_type, foreign_key: true
    add_reference :calendar_events, :academic_term, foreign_key: true
  end
end
