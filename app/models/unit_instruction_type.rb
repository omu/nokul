# frozen_string_literal: true

class UnitInstructionType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :units, dependent: :nullify
end
