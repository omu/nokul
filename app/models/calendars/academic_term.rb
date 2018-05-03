# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  # relations
  has_many :academic_calendars

  # validations
  validates :year, :term, presence: true
  validates :year, uniqueness: { scope: :term }

  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }

  def self.years
    (1975..Time.now.year).map { |year| "#{year}-#{year + 1}" }.reverse
  end
end
