class City < ApplicationRecord
  # iso field follows the ISO3166 standard, nuts_code field follows the NUTS-1 standard.

  # relations
  belongs_to :region
  belongs_to :country
  has_many :universities, dependent: :nullify

  # validations
  validates :name, :iso, :nuts_code, presence: true, uniqueness: true, strict: true
end
