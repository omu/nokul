# frozen_string_literal: true

class Language < ApplicationRecord
  # search
  include ReferenceSearch

  # callbacks
  before_validation :capitalize_attributes

  # relations
  has_many :courses, dependent: :nullify
  has_many :prospective_students, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :iso, presence: true, uniqueness: true, length: { maximum: 255 }

  private

  def capitalize_attributes
    self.name = name.capitalize_turkish if name
    self.iso  = iso.upcase(:turkic) if iso
  end
end
