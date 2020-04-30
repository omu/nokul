# frozen_string_literal: true

class CalendarEventDecorator < SimpleDelegator
  def active_now?
    return unless presence

    end_time ? Time.current.between?(start_time, end_time) : start_time.past?
  end

  def date_range
    return translate('undefined_date_range') unless presence

    translate(
      'date_range',
      start_time: start_time&.strftime('%F %R'),
      end_time:   end_time&.strftime('%F %R')
    )
  end

  private

  def translate(key, params = {})
    I18n.t("calendar_management.calendars.#{key}", **params)
  end
end
