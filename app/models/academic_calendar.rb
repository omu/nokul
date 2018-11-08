# frozen_string_literal: true

class AcademicCalendar < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name],
    using: { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :academic_term
  belongs_to :calendar_type
  has_many :calendar_events, dependent: :destroy
  has_many :unit_calendar_events, dependent: :destroy
  accepts_nested_attributes_for :calendar_events, allow_destroy: true

  # validations
  validates :name, presence: true
  validates :senate_decision_date, presence: true
  validates :senate_decision_no, presence: true
  validates :academic_term, uniqueness: { scope: :calendar_type }

  # delegates
  delegate :name, to: :calendar_type, prefix: :type

  # scopes
  scope :active, -> { joins(:academic_term).merge(AcademicTerm.where(active: true)) }
end
