# frozen_string_literal: true

class Standard < ApplicationRecord
  # search
  include DynamicSearch

  # dynamic_search
  search_keys :accreditation_institution_id, :version, :status

  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :accreditation_institution
  has_many :macro_outcomes, -> { where(parent_id: nil) }, class_name: 'Outcome', inverse_of: :standard
  has_many :outcomes, dependent: :destroy
  has_many :unit_standards, dependent: :destroy
  has_many :units, through: :unit_standards

  # validations
  validates :status, inclusion: { in: statuses.keys }
  validates :version, presence: true, uniqueness: { scope: :accreditation_institution_id }, length: { maximum: 50 }
  validates_associated :unit_standards

  # delegates
  delegate :name, to: :accreditation_institution
end
