# frozen_string_literal: true

class CreateAcademicCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_calendars do |t|
      t.string :name, null: false, limit: 255
      t.date :senate_decision_date, null: false
      t.string :senate_decision_no, null: false, limit: 255
      t.text :description, limit: 65535
      t.references :academic_term
      t.references :calendar_type
      t.timestamps
    end
  end
end
