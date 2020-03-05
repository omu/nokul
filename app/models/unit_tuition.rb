# frozen_string_literal: true

class UnitTuition < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :tuition

  # validations
  validates :tuition_id, uniqueness: { scope: :unit_id }
  validates_with UnitTuitionValidator

  # delegates
  delegate :academic_term, to: :tuition
end
