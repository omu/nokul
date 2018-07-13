# frozen_string_literal: true

class Project < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :user

  # validations
  validates :yoksis_id, presence: true

  # enums
  enum status: {
    completed: 1,
    continuing: 2,
    deferred: 3,
    pending: 4
  }

  enum activity: { passive: 0, active: 1 }
  enum scope: { national: 0, international: 1 }
end
