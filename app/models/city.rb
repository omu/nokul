class City < ApplicationRecord
  # iso field follows the ISO3166 standard, nuts_code field follows the NUTS-1 standard.

  # relations
  belongs_to :region, inverse_of: 'cities'
  belongs_to :country, inverse_of: 'cities'

  # validations
  validates :name, :iso, :nuts_code, presence: true, uniqueness: true, strict: true
end
