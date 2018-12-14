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
  has_many :calendar_units, dependent: :destroy
  has_many :units, through: :calendar_units
  accepts_nested_attributes_for :calendar_events, allow_destroy: true

  # validations
  validates :name, presence: true, length: { maximum: 255 }
  validates :senate_decision_date, presence: true
  validates :senate_decision_no, presence: true, length: { maximum: 255 }
  validates :academic_term, uniqueness: { scope: :calendar_type }
  validates :description, length: { maximum: 65535 }
  validates :units, presence: true, on: :update

  # delegates
  delegate :name, to: :calendar_type, prefix: :type
  delegate :active?, to: :academic_term

  # scopes
  scope :active, -> { joins(:academic_term).merge(AcademicTerm.where(active: true)) }

  def proper_event_range?(title)
    event = calendar_events.find_by(calendar_title: CalendarTitle.find_by(identifier: title))
    event.present? && event.proper_range?
  end
end
