# frozen_string_literal: true

class UnitInstructionLanguage < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks

  # relations
  has_many :units, dependent: :nullify
end
