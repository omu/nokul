# frozen_string_literal: true

class AdministrativeFunction < ApplicationRecord
  # callbacks
  before_validation :capitalize_attributes

  # relations
  has_many :positions, dependent: :destroy
  has_many :duties, through: :positions

  # validations
  validates :code, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

  private

  def capitalize_attributes
    self.name = name.capitalize_turkish if name
  end
end
