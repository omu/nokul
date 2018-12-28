# frozen_string_literal: true

class CalendarEvent < ApplicationRecord
  # relations
  belongs_to :calendar
  belongs_to :calendar_event_type

  # validations
  validates :timezone, presence: true, length: { maximum: 255 }
  validates :calendar, uniqueness: { scope: %i[calendar_event_type] }
  validates :visible, inclusion: { in: [true, false] }
  validates_with CalendarEventValidator

  def active_now?
    Time.current.between?(start_time, end_time)
  end
end
