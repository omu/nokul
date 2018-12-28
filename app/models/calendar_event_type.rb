# frozen_string_literal: true

class CalendarEventType < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name identifier],
    using: { tsearch: { prefix: true } }
  )

  # relations
  has_many :calendar_events, dependent: :destroy
  has_many :calendars, -> { distinct }, through: :calendar_events

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :identifier, presence: true, uniqueness: true, length: { maximum: 255 }
end
