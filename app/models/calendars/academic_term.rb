# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  # relations
  has_many :academic_calendars, dependent: :nullify

  # validations
  validates :year, presence: true
  validates :term, presence: true
  validates :year, uniqueness: { scope: :term }

  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }

  def self.years
    (1975..Time.now.year).map { |year| "#{year}-#{year + 1}" }.reverse
  end

  def fullname
    "#{year} / #{term}"
  end
end
