# frozen_string_literal: true

class UnitInstructionLanguage < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :units, dependent: :nullify
end
