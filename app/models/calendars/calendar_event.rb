# frozen_string_literal: true

class CalendarEvent < ApplicationRecord
  # relations
  belongs_to :academic_calendar
  belongs_to :calendar_title

  # validations
  validates :start_date, presence: true
  validates :academic_calendar, uniqueness: { scope: :calendar_title }

  # delegates
  delegate :name, to: :calendar_title, prefix: :calendar_title
end
