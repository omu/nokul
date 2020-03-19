# frozen_string_literal: true

class Standard < ApplicationRecord
  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :accreditation_standard
  has_many :macro_outcomes, -> { where(parent_id: nil) }, class_name: 'Outcome', inverse_of: :standard
  has_many :outcomes, dependent: :destroy
  has_many :unit_standards, dependent: :destroy
  has_many :units, through: :unit_standards

  # validations
  validates :status, inclusion: { in: statuses.keys }
  validates_associated :unit_standards

  # delegates
  delegate :name, to: :accreditation_standard
end
