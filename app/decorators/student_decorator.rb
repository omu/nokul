# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def event_online_course_registrations
    @event_online_course_registrations ||= CalendarEventDecorator.new(calendar&.event('online_course_registrations'))
  end

  private

  def calendar
    calendars.last
  end
end
