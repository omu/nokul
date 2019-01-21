# frozen_string_literal: true

class CreateCalendarEventTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_event_types do |t|
      t.string :name
      t.string :identifier
      t.integer :category
    end

    add_presence_constraint :calendar_event_types, :name
    add_presence_constraint :calendar_event_types, :identifier
    add_null_constraint :calendar_event_types, :category

    add_length_constraint :calendar_event_types, :name, less_than_or_equal_to: 255
    add_length_constraint :calendar_event_types, :identifier, less_than_or_equal_to: 255

    add_unique_constraint :calendar_event_types, :identifier
    add_unique_constraint :calendar_event_types, :name

    add_numericality_constraint :calendar_event_types, :category, greater_than_or_equal_to: 0
  end
end
