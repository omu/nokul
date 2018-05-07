# frozen_string_literal: true

class StudentStudentshipStatus < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
end
