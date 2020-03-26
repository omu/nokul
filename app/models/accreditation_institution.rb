# frozen_string_literal: true

class AccreditationInstitution < ApplicationRecord
  # search
  include ReferenceSearch

  # relations
  has_many :accreditation_standards, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
