# frozen_string_literal: true

class StudentEducationLevel < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch
end
