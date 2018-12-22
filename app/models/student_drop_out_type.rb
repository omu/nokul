# frozen_string_literal: true

class StudentDropOutType < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch
end
