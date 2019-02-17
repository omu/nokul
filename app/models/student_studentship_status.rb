# frozen_string_literal: true

class StudentStudentshipStatus < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations
end
