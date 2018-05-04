# frozen_string_literal: true

class UnitCalendarEvent < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :academic_calendar
  belongs_to :calendar_title

  # validations
  validates :start_date, presence: true
  validates :unit_id, uniqueness: { scope: %i[academic_calendar_id calendar_title_id] }
end
