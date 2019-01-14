# frozen_string_literal: true

class RegistrationDocument < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :academic_term
  belongs_to :document_type

  # validations
  validates :unit_id, uniqueness: { scope: %i[academic_term document_type] }
  validates :description, length: { maximum: 65_535 }

  # delegates
  delegate :name, to: :document_type
  delegate :active, to: :document_type
end
