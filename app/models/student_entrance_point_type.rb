# frozen_string_literal: true

class StudentEntrancePointType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations
end
