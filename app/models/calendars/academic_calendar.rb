# frozen_string_literal: true

class AcademicCalendar < ApplicationRecord
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
end
