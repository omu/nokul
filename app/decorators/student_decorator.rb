# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def registrable_for_online_course?
    online_course_registrations_event.try(:active_now?)
  end

  def registrable_for_online_course_date_range
    online_course_registrations_event.date_range
  end

  private

  def calendar
    calendars.last
  end

  def online_course_registrations_event
    @online_course_registrations_event ||=
      CalendarEventDecorator.new(calendar&.event('online_course_registrations'))
  end
end
