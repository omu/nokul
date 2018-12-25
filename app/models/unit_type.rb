# frozen_string_literal: true

class UnitType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch

  # enums
  enum group: {
    other: 0,
    university: 1,
    faculty: 2,
    department: 3,
    program: 4,
    committee: 5,
    major: 6,
    institute: 7,
    rectorship: 8
  }

  validates :group, allow_nil: true, inclusion: { in: groups.keys }

  # relations
  has_many :units, dependent: :nullify
end
