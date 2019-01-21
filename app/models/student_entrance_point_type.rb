# frozen_string_literal: true

class StudentEntrancePointType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch
end
