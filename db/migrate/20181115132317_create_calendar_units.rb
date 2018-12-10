# frozen_string_literal: true

class CreateCalendarUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_units do |t|
      t.references :academic_calendar,
                   foreign_key: true,
                   null: false
      t.references :unit,
                   foreign_key: true,
                   null: false
    end
  end
end
