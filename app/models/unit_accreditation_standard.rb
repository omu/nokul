# frozen_string_literal: true

class UnitAccreditationStandard < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :accreditation_standard

  # validations
  validates :accreditation_standard, uniqueness: { scope: :unit }
  validates_with UnitAccreditationStandardValidator
end
