# frozen_string_literal: true

class AssessmentMethod < ApplicationRecord
  # search
  include ReferenceSearch
  include ReferenceCallbacks

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
