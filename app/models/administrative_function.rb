# frozen_string_literal: true

class AdministrativeFunction < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :positions, dependent: :destroy
  has_many :duties, through: :positions
end
