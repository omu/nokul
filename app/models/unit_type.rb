# frozen_string_literal: true

class UnitType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # enums
  enum group: {
    other: 0,
    faculty: 1,
    department: 2,
    major: 3,
    undergraduate_program: 4,
    graduate_program: 5,
    institute: 6,
    research_center: 7,
    committee: 8,
    administrative: 9
  }

  # scopes
  scope :program, -> { where(group: %w[undergraduate_program graduate_program]) }
  scope :senate, -> { where(name: 'Senato') }

  # relations
  has_many :units, dependent: :nullify

  # validations
  validates :group, allow_nil: true, inclusion: { in: groups.keys }
end
