# frozen_string_literal: true

class UniversityType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :units, dependent: :nullify
end
