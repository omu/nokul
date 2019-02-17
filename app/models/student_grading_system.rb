# frozen_string_literal: true

class StudentGradingSystem < ApplicationRecord
  include ReferenceCallbacks
  include ReferenceSearch
  include ReferenceValidations
end
