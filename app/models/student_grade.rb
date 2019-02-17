# frozen_string_literal: true

class StudentGrade < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations
end
