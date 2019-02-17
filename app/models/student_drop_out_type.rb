# frozen_string_literal: true

class StudentDropOutType < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations
end
