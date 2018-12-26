# frozen_string_literal: true

class Calendar < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name],
    using: { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :academic_term
  has_many :calendar_events, dependent: :destroy
  has_many :calendar_event_types, through: :calendar_events
  has_many :unit_calendars, dependent: :destroy
  has_many :units, through: :unit_calendars

  # validations
  validates :name, presence: true, uniqueness: { scope: %i[senate_decision_no] }, length: { maximum: 255 }
  validates :timezone, presence: true, length: { maximum: 255 }
  validates :senate_decision_no, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }
end
