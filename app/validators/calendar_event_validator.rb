# frozen_string_literal: true

class CalendarEventValidator < ActiveModel::Validator
  def validate(record)
    @event = record
    @academic_term = record.calendar.academic_term

    term_start_time_validation if @event.start_time?
    term_end_time_validation if @event.end_time?
    date_range_validation if @event.start_time? && @event.end_time?
  end

  def term_start_time_validation
    @event.errors[:start_time] << message('invalid_start_time') if @event.start_time <= @academic_term.start_of_term
  end

  def term_end_time_validation
    @event.errors[:end_time] << message('invalid_end_time') if @event.end_time >= @academic_term.end_of_term
  end

  def date_range_validation
    @event.errors[:end_time] << message('invalid_time_range') if @event.end_time < @event.start_time
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators calendar_event])
  end
end
