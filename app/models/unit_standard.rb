# frozen_string_literal: true

class UnitStandard < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :standard

  # validations
  validates :standard, uniqueness: { scope: :unit }
  validates_with UnitStandardValidator
end
