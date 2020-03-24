# frozen_string_literal: true

class AccreditationStandard < ApplicationRecord
  # search
  include ReferenceSearch

  # relations
  has_many :standards, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
end
