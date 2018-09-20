# frozen_string_literal: true

class UnitStatus < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks

  # relations
  has_many :units, dependent: :nullify

  # scopes
  scope :active, -> { where(code: 1) }
end
