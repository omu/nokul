# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }

  # relations
  has_many :academic_calendars, dependent: :nullify
  has_many :calendar_events, through: :academic_calendars

  # validations
  validates :year, presence: true, uniqueness: { scope: :term }, length: { maximum: 255 }
  validates :term, presence: true, inclusion: { in: terms.keys }
  validates :start_of_term, presence: true
  validates :end_of_term, presence: true
  validates :active, inclusion: { in: [true, false] }

  # scopes
  scope :active, -> { where(active: true) }
end
