class Region < ApplicationRecord
  # nuts_code field follows the NUTS-1 standard, since there is no ISO schema for Turkish regions.

  # relations
  belongs_to :country, inverse_of: 'regions'
  has_many :cities, dependent: :destroy, inverse_of: 'region'

  # validations
  validates :name, :nuts_code, presence: true, uniqueness: true, strict: true
  validates_associated :cities
end
