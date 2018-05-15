# frozen_string_literal: true

class UnitCalendarEvent < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :academic_calendar
  belongs_to :calendar_title

  # validations
  validates :start_date, presence: true
  validates :unit, uniqueness: { scope: %i[academic_calendar calendar_title] }
end
