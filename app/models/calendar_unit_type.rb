# frozen_string_literal: true

class CalendarUnitType < ApplicationRecord
  # relations
  belongs_to :calendar_type
  belongs_to :unit_type

  # validations
  validates :unit_type, uniqueness: { scope: :calendar_type }
end
