# frozen_string_literal: true

module DateHelper
  def as_date(date = nil)
    date&.strftime('%d.%m.%Y')
  end

  def as_date_and_time(date = nil)
    date&.strftime('%d.%m.%Y - %H:%M')
  end

  def selectible_year_range(start)
    Time.zone.now.year.downto(start).map { |year| "#{year} - #{year + 1}" }
  end
end
