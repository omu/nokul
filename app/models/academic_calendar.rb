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
  validates :name, presence: true
  validates :senate_decision_date, presence: true
  validates :senate_decision_no, presence: true
  validates :academic_term, uniqueness: { scope: :calendar_type }
  validates :units, presence: true, on: :update

  # delegates
  delegate :name, to: :calendar_type, prefix: :type
  delegate :active?, to: :academic_term

  # scopes
  scope :active, -> { joins(:academic_term).merge(AcademicTerm.where(active: true)) }
end
