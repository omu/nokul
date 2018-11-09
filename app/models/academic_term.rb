# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  # relations
  has_many :academic_calendars, dependent: :nullify
  has_many :calendar_events, through: :academic_calendars

  # validations
  validates :term, presence: true
  validates :year, presence: true, uniqueness: { scope: :term }
  validates :start_of_term, presence: true
  validates :end_of_term, presence: true

  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }
end
