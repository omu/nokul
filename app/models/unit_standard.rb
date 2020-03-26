# frozen_string_literal: true

class UnitStandard < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :accreditation_standard

  # validations
  validates :accreditation_standard, uniqueness: { scope: :unit }
  validates_with UnitStandardValidator
end
