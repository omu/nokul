# frozen_string_literal: true

class UnitStatus < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch

  # relations
  has_many :units, dependent: :nullify

  # scopes
  scope :passive,           -> { where(code: 0) }
  scope :active,            -> { where(code: 1) }
  scope :partially_passive, -> { where(code: 2) }
  scope :closed,            -> { where(code: 3) }
  scope :archived,          -> { where(code: 4) }
  scope :no_guide_code,     -> { where(code: 5) }
end
