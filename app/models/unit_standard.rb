# frozen_string_literal: true

class UnitStandard < ApplicationRecord
  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :standard
  belongs_to :unit
  has_many :outcomes, dependent: :destroy
  has_many :macro_outcomes, -> { where(parent_id: nil) }, class_name: 'Outcome', inverse_of: :unit_standard

  # validations
  validates :standard, presence: true, uniqueness: { scope: :unit }
  validates :status, inclusion: { in: statuses.keys }, uniqueness: { scope: :unit }
end
