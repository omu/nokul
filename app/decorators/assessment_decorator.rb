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
    course_evaluation_type.available_course.unit.calendars.last
  end
end
