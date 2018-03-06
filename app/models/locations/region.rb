class Region < ApplicationRecord
  # nuts_code field follows the NUTS-1 standard, since there is no ISO schema for Turkish regions.

  # relations
  belongs_to :country
  has_many :cities, dependent: :destroy

  # validations
  validates :name, :nuts_code, presence: true, uniqueness: true, strict: true
  validates_associated :cities

  # callbacks
  before_create do
    self.name = name.mb_chars.titlecase
    self.nuts_code = nuts_code.mb_chars.upcase
  end
end
