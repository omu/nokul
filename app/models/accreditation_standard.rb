# frozen_string_literal: true

class AccreditationStandard < ApplicationRecord
  # search
  include DynamicSearch

  # dynamic_search
  search_keys :accreditation_institution_id, :version, :status

  # enums
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :accreditation_institution
  has_many :learning_outcomes, dependent: :destroy
  has_many :macro_learning_outcomes, -> { where(parent_id: nil) },
           class_name: 'LearningOutcome', inverse_of: :accreditation_standard
  has_many :unit_accreditation_standards, dependent: :destroy
  has_many :units, through: :unit_accreditation_standards

  # validations
  validates :status, inclusion: { in: statuses.keys }
  validates :version, presence: true, uniqueness: { scope: :accreditation_institution_id }, length: { maximum: 50 }
  validates_associated :unit_accreditation_standards

  # delegates
  delegate :name, to: :accreditation_institution
end
