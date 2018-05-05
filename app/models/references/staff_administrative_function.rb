# frozen_string_literal: true

class StaffAdministrativeFunction < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
end
