# frozen_string_literal: true

class RemoveSenateDecisionColumnsFromCalendar < ActiveRecord::Migration[6.0]
  def change
    remove_column :calendars, :senate_decision_date, :date
    remove_column :calendars, :senate_decision_no, :string
  end
end
