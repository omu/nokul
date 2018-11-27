# frozen_string_literal: true

class CalendarEvent < ApplicationRecord
  # relations
  belongs_to :academic_calendar
  belongs_to :calendar_title
  belongs_to :calendar_type, optional: true
  belongs_to :academic_term, optional: true

  # validations
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :academic_calendar, uniqueness: { scope: :calendar_title }
  validates_with CalendarEventValidator

  # callbacks
  after_create :set_calendar_type_and_term

  # delegates
  delegate :name, to: :calendar_title, prefix: :calendar_title

  # scopes
  scope :active, -> { where(academic_term: AcademicTerm.active) }

  def set_calendar_type_and_term
    update(calendar_type_id: academic_calendar.calendar_type.id,
           academic_term_id: academic_calendar.academic_term.id)
  end

  def proper_range?
    Time.current >= start_date && Time.current <= end_date
  end
end
