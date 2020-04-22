# frozen_string_literal: true

namespace :fix_data do
  desc 'Creates missing unit calendar data for departments'
  task department_calendars: :environment do
    UnitCalendar.all.each do |unit_calendar|
      unit_calendar.unit.descendants.active.departments.each do |descendant|
        UnitCalendar.create(calendar: unit_calendar.calendar, unit: descendant)
      end
    end
  end
end
