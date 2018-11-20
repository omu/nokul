# frozen_string_literal: true

class CalendarUnit < ApplicationRecord
  # relations
  belongs_to :academic_calendar
  belongs_to :unit

  # validations
  validates :unit, uniqueness: { scope: :academic_calendar }
end
