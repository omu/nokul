# frozen_string_literal: true

class StudentGradingSystem < ApplicationRecord
  include ReferenceValidations
  include ReferenceCallbacks
  include ReferenceSearch
end
