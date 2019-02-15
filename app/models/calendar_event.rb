# frozen_string_literal: true

class CalendarEvent < ApplicationRecord
  # relations
  belongs_to :calendar
  belongs_to :calendar_event_type

  # validations
  validates :calendar, uniqueness: { scope: %i[calendar_event_type] }
  validates :start_time, presence: true
  validates :timezone, presence: true, length: { maximum: 255 }
  validates :visible, inclusion: { in: [true, false] }
  validates_with CalendarEventValidator

  # delegations
  delegate :name, to: :calendar_event_type, prefix: :type

  def active_now?
    end_time ? Time.current.between?(start_time, end_time) : start_time.past?
  end
end
