# frozen_string_literal: true

class CalendarType < ApplicationRecord
  # relations
  has_many :calendar_title_types, foreign_key: :type_id, inverse_of: :type, dependent: :destroy
  has_many :titles, through: :calendar_title_types
  has_many :academic_calendars, dependent: :destroy
  has_many :calendar_unit_types, dependent: :destroy
  has_many :unit_types, through: :calendar_unit_types
  has_many :calendar_events, through: :academic_calendars

  # validations
  validates :name, presence: true, uniqueness: true
end
