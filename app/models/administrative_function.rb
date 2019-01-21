# frozen_string_literal: true

class AdministrativeFunction < ApplicationRecord
  # relations
  has_many :positions, dependent: :destroy
  has_many :duties, through: :positions

  # validations
  validates :name, presence: true, uniqueness: true
  validates :code, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }

  # callbacks
  before_validation { self.name = name.capitalize_turkish if name }
end
