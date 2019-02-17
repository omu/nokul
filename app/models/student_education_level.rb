# frozen_string_literal: true

class StudentEducationLevel < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations
end
