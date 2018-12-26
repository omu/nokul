# frozen_string_literal: true

class CreateUnitCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :unit_calendars do |t|
      t.references :calendar,
                   foreign_key: true,
                   null: false
      t.references :unit,
                   foreign_key: true,
                   null: false
    end
  end
end
