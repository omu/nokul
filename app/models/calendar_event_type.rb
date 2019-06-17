# frozen_string_literal: true

class CalendarEventType < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name identifier],
    using:   { tsearch: { prefix: true } }
  )

  # enums
  enum category: {
    applications:  1,
    payments:      2,
    registrations: 3,
    advisor:       4,
    exams:         5,
    courses:       6,
    submission:    7,
    announcement:  8
  }

  # relations
  has_many :calendar_events, dependent: :destroy
  has_many :calendars, through: :calendar_events

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :identifier, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :category, inclusion: { in: categories.keys }
end
