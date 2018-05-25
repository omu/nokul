# frozen_string_literal: true

class Country < ApplicationRecord
  # name, iso and code fields follow the ISO3166 standard.

  # relations
  has_many :regions, dependent: :nullify
  has_many :cities, through: :regions
  has_many :districts, through: :cities
  has_many :addresses, through: :districts
  has_many :units, through: :districts

  # validations
  validates :name, presence: true, uniqueness: true
  validates :iso, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.iso = iso.upcase_tr
  end
end
