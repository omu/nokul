# frozen_string_literal: true

class StudentDisabilityType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
end
