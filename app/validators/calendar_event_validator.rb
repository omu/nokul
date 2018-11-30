# frozen_string_literal: true

class CalendarEventValidator < ActiveModel::Validator
  def validate(record)
    @event = record
    @term = record.academic_calendar.academic_term

    term_start_date_validation if @event.start_date?
    term_end_date_validation if @event.end_date?
    date_range_validation if @event.start_date? && @event.end_date?
  end

  def term_start_date_validation
    @event.errors[:start_date] << message('invalid_start_date') if @event.start_date <= @term.start_of_term
  end

  def term_end_date_validation
    @event.errors[:end_date] << message('invalid_end_date') if @event.end_date >= @term.end_of_term
  end

  def date_range_validation
    @event.errors[:end_date] << message('invalid_date_range') if @event.end_date < @event.start_date
  end

  private

  def message(key)
    I18n.t(key, scope: %i[validators calendar_event])
  end
end
