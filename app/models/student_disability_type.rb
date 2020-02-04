# frozen_string_literal: true

class StudentDisabilityType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations

  # relations
  has_many :prospective_students, dependent: :nullify
  has_many :users, foreign_key: :disability_type_id, inverse_of: :disability_type, dependent: :nullify
end
