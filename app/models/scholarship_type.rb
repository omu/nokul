# frozen_string_literal: true

class ScholarshipType < ApplicationRecord
  # search
  include ReferenceSearch

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :active, inclusion: { in: [true, false] }
end
