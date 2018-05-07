# frozen_string_literal: true

class Country < ApplicationRecord
  # name, iso and code fields follow the ISO3166 standard.

  # relations
  has_many :regions, dependent: :nullify
  has_many :cities, through: :regions
  has_many :districts, through: :cities
  has_many :units, through: :districts

  # validations
  validates :name, :iso, :code,
            presence: true, uniqueness: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.iso = iso.upcase_tr
  end
end
