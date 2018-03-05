class Country < ApplicationRecord
  # name, iso and code fields follow the ISO3166 standard.

  # relations
  has_many :cities, dependent: :destroy, inverse_of: 'country'
  has_many :regions, dependent: :destroy, inverse_of: 'country'

  # validations
  validates :name, :iso, :code, presence: true, uniqueness: true, strict: true
  validates_associated :cities
  validates_associated :regions
end
