# frozen_string_literal: true

class Calendar < ApplicationRecord
  # search
  include PgSearch::Model
  pg_search_scope(
    :search,
    against: %i[name],
    using:   { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :academic_term
  has_many :calendar_committee_decisions, dependent: :destroy
  has_many :calendar_events, dependent: :destroy
  has_many :calendar_event_types, through: :calendar_events
  has_many :committee_decisions, through: :calendar_committee_decisions
  has_many :unit_calendars, dependent: :destroy
  has_many :units, through:       :unit_calendars,
                   before_add:    proc { |calendar, unit| create_sub_calendars(calendar, unit) },
                   before_remove: proc { |calendar, unit| destroy_sub_calendars(calendar, unit) }

  accepts_nested_attributes_for :units, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :calendar_events, allow_destroy: true, reject_if: :all_blank

  # validations
  validates_associated :calendar_events
  validates :name, presence:   true,
                   uniqueness: { scope: :academic_term_id },
                   length:     { maximum: 255 }
  validates :committee_decisions, presence: true
  validates :timezone, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 65_535 }

  # delegations
  delegate :active?, to: :academic_term

  # scopes
  scope :active, -> { joins(:academic_term).merge(AcademicTerm.where(active: true)) }

  # relational callbacks
  class << self
    def create_sub_calendars(calendar, unit)
      unit.descendants.active.eventable.each do |descendant|
        UnitCalendar.create(calendar: calendar, unit: descendant)
      end
    end

    def destroy_sub_calendars(calendar, unit)
      UnitCalendar.where(calendar_id: calendar.id, unit_id: unit.descendants.ids).destroy_all
    end
  end

  def event(identifier)
    return unless (type = event_type(identifier))

    calendar_events.find_by(calendar_event_type: type)
  end

  private

  def event_type(identifier)
    CalendarEventType.find_by(identifier: identifier)
  end
end
