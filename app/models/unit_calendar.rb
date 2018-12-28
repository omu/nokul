# frozen_string_literal: true

class UnitCalendar < ApplicationRecord
  # relations
  belongs_to :calendar
  belongs_to :unit

  # callbacks
  after_create do |unit_calendar|
    unit_calendar.unit.descendants.each do |descendant|
      UnitCalendar.create(calendar: unit_calendar.calendar, unit: descendant)
    end
  end

  before_destroy do |unit_calendar|
    descendant_ids = unit_calendar.unit.descendants.ids
    calendar_id = unit_calendar.calendar.id

    descendant_ids do |descendant_id|
      UnitCalendar.where(calendar_id: calendar_id, unit_id: descendant_id).destroy_all
    end
  end
end
