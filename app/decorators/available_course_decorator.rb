# frozen_string_literal: true

class AvailableCourseDecorator < SimpleDelegator
  def reifiable?
    add_drop_available_courses_event.try(:active_now?)
  end

  private

  def calendar
    calendars.active.last
  end

  def add_drop_available_courses_event
    @add_drop_available_courses_event ||= calendar&.event('add_drop_available_courses')
  end
end
