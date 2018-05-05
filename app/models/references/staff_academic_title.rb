# frozen_string_literal: true

class StaffAcademicTitle < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
end
