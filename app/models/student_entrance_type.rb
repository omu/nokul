# frozen_string_literal: true

class StudentEntranceType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch

  has_many :prospective_students, dependent: :destroy
end
