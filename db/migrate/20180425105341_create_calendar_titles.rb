# frozen_string_literal: true

class CreateCalendarTitles < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_titles do |t|
      t.string :name
      t.string :identifier
      t.timestamps
    end

    add_presence_constraint :calendar_titles, :name
    add_presence_constraint :calendar_titles, :identifier
    add_length_constraint :calendar_titles, :name, less_than_or_equal_to: 255
    add_length_constraint :calendar_titles, :identifier, less_than_or_equal_to: 255
  end
end
