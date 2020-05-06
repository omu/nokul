# frozen_string_literal: true

class AssessmentDecorator < SimpleDelegator
  def editable?
    !saved? && saved_enrollments.any?
  end

  def saveable?
    draft? && fully_graded?
  end

  def results_announcement_event
    @results_announcement_event ||= CalendarEventDecorator.new(calendar&.event(identifier))
  end

  private

  def calendar
    available_course.calendars.last
  end
end
