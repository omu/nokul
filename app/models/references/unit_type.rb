# frozen_string_literal: true

class UnitType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks

  # relations
  has_many :units, dependent: :nullify

  # enums
  enum group: {
    other: 0,
    university: 1,
    faculty: 2,
    department: 3,
    program: 4,
    committee: 5
  }
end
