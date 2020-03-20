# frozen_string_literal: true

class UnitInstructionType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :units, dependent: :nullify

  # scopes
  scope :distance, -> { where(code: 3) }
  scope :normal, -> { where(code: 1) }
  scope :open, -> { where(code: 4) }
  scope :secondary, -> { where(code: 2) }
end
