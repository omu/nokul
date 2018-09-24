# frozen_string_literal: true

class UnitInstructionType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks

  # relations
  has_many :units, dependent: :nullify
end
