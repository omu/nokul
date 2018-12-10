# frozen_string_literal: true

class CreateAcademicCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :academic_calendars do |t|
      t.string :name
      t.date :senate_decision_date
      t.string :senate_decision_no
      t.string :description
      t.references :academic_term,
                   null: false,
                   foreign_key: true
      t.references :calendar_type,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :academic_calendars, :name
    add_presence_constraint :academic_calendars, :senate_decision_date
    add_presence_constraint :academic_calendars, :senate_decision_no

    add_length_constraint :academic_calendars, :name, less_than_or_equal_to: 255
    add_length_constraint :academic_calendars, :senate_decision_no, less_than_or_equal_to: 255
    add_length_constraint :academic_calendars, :description, less_than_or_equal_to: 65535
  end
end
