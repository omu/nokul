# frozen_string_literal: true

class CalendarEventDecorator < SimpleDelegator
  def date_range
    return I18n.t('calendar_management.calendar_events.undefined_date_range') unless presence

    "#{start_time&.strftime('%F %R')} - #{end_time&.strftime('%F %R')}"
  end
end
