# frozen_string_literal: true

class CalendarEvent < ApplicationRecord
  # relations
  belongs_to :academic_calendar
  belongs_to :calendar_title

  # validations
  validates :start_date, presence: true
  validates :academic_calendar_id, uniqueness: { scope: :calendar_title_id }
end
