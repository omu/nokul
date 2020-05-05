# frozen_string_literal: true

class CalendarEventDecorator < SimpleDelegator
  def active_now?
    return unless presence

    end_time ? Time.current.between?(start_time, end_time) : start_time.past?
  end

  def date_range
    return I18n.t('calendar_management.calendar_events.undefined_date_range') unless presence

    "#{start_time&.strftime('%F %R')} - #{end_time&.strftime('%F %R')}"
  end
end
