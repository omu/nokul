# frozen_string_literal: true

class UnitStandard < ApplicationRecord
  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :standard
  belongs_to :unit

  # validations
  validates :standard, presence: true, uniqueness: { scope: :unit }
  validates :status, inclusion: { in: statuses.keys }
end
