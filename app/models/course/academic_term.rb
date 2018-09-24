# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  # relations
  has_many :academic_calendars, dependent: :nullify

  # validations
  validates :term, presence: true
  validates :year, presence: true, uniqueness: { scope: :term }

  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }
end
