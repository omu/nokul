# frozen_string_literal: true

class UnitInstructionType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :units, dependent: :nullify

  # scopes
  scope :daytime, -> { where(code: 1) }
  scope :distance, -> { where(code: 3) }
  scope :evening, -> { where(code: 2) }
  scope :open, -> { where(code: 4) }
end
