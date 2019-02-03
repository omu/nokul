# frozen_string_literal: true

class AdministrativeFunction < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch

  # relations
  has_many :positions, dependent: :destroy
  has_many :duties, through: :positions
end
