# frozen_string_literal: true

module AcademicCalendars
  class DuplicateEventsService
    attr_reader :from_calendar, :to_calendar

    def initialize(from_calendar, to_calendar)
      @from_calendar = from_calendar
      @to_calendar = to_calendar
      duplicate_calendar_events
    end

    private

    def duplicate_calendar_events
      @from_calendar.calendar_events.each do |calendar_event|
        clone_event = calendar_event.dup
        clone_event.calendar = @to_calendar
        clone_event.save!
      end
    end
  end
end
