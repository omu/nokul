# frozen_string_literal: true

class UnitCalendar < ApplicationRecord
  # relations
  belongs_to :calendar
  belongs_to :unit

  # validations
  validates :calendar, presence: true, uniqueness: { scope: :unit }
end
