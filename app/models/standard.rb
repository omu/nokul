# frozen_string_literal: true

class Standard < ApplicationRecord
  # search
  include ReferenceSearch

  # relations
  has_many :unit_standards, dependent: :destroy

  # validations
  validates :version, presence: true, length: { maximum: 50 }
  validates :name, presence: true, uniqueness: { scope: :version }, length: { maximum: 255 }
end
