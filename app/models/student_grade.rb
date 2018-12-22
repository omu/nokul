# frozen_string_literal: true

class StudentGrade < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch
end
