# frozen_string_literal: true

class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.string :name
      t.date :senate_decision_date
      t.string :senate_decision_no
      t.string :description
      t.string :timezone, default: 'Istanbul'
      t.references :academic_term,
                   null: false,
                   foreign_key: true
      t.timestamps
    end

    add_presence_constraint :calendars, :name
    add_presence_constraint :calendars, :timezone
    add_presence_constraint :calendars, :senate_decision_no

    add_length_constraint :calendars, :name, less_than_or_equal_to: 255
    add_length_constraint :calendars, :timezone, less_than_or_equal_to: 255
    add_length_constraint :calendars, :senate_decision_no, less_than_or_equal_to: 255
    add_length_constraint :calendars, :description, less_than_or_equal_to: 65_535
  end
end
