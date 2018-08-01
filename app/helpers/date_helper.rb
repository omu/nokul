# frozen_string_literal: true

module DateHelper
  def as_date(date = nil)
    date = date.strftime('%d.%m.%Y') if date
  end

  def as_date_and_time(date = nil)
    date = date.strftime('%d.%m.%Y - %H:%M') if date
  end
end