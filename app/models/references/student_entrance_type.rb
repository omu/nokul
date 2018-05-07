# frozen_string_literal: true

class StudentEntranceType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
end
