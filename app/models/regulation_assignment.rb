# frozen_string_literal: true

class RegulationAssignment < ApplicationRecord
  RELATABLE_MODELS = %w[Unit].freeze

  # relations
  belongs_to :regulation
  belongs_to :assignable, polymorphic: true

  # validations

  validates :assignable_type, inclusion: { in: RELATABLE_MODELS }
end
