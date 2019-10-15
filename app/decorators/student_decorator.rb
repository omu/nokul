# frozen_string_literal: true

class StudentDecorator < SimpleDelegator
  def calendar
    unit.calendars.find_by(academic_term: term)
  end

  def registrable_for_online_course?
    calendar&.check_events('online_course_registrations')
  end

  private

  def term
    AcademicTerm.active.last
  end
end
