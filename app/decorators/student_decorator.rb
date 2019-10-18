# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def calendar
    calendars.last
  end

  def registrable_for_online_course?
    calendar&.check_events('online_course_registrations')
  end

  # TODO
  def enrolled_courses
    course_enrollments.includes(:available_course)
                      .where(year: 1, sequence: 1)
  end
end
