# frozen_string_literal: true

class AcademicTerm < ApplicationRecord
  # enums
  enum term: { fall: 0, spring: 1, summer: 2 }

  # relations


  # validations
  validates :year, presence: true, uniqueness: { scope: :term }, length: { maximum: 255 }
  validates :term, inclusion: { in: terms.keys }
  validates :start_of_term, presence: true
  validates :end_of_term, presence: true
  validates :active, inclusion: { in: [true, false] }

  # scopes
  scope :active, -> { where(active: true) }
end
