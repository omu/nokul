# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def registrable_for_online_course?
    event_online_course_registrations.try(:active_now?)
  end

  def registation_date_range
    translate(
      'index.registration_date_range',
      start_time: event_online_course_registrations&.start_time&.strftime('%F %R'),
      end_time:   event_online_course_registrations&.end_time&.strftime('%F %R')
    )
  end

  private

  def calendar
    calendars.last
  end

  def event_online_course_registrations
    calendar&.event('online_course_registrations')
  end

  def translate(key, params = {})
    I18n.t("studentship.course_enrollments.#{key}", **params)
  end
end
