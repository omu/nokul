# frozen_string_literal: true

class AssessmentDecorator < SimpleDelegator
  def editable?
    !saved? && saved_enrollments.any?
  end

  def saveable?
    draft? && fully_graded?
  end

  def gradable?
    results_announcement_event.try(:active_now?)
  end

  def gradable_date_range
    results_announcement_event.date_range
  end

  private

  def calendar
    available_course.calendars.last
  end

  def results_announcement_event
    @results_announcement_event ||=
      CalendarEventDecorator.new(calendar&.event("#{identifier}_results_announcement"))
  end
end
