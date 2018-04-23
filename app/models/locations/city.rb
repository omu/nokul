# frozen_string_literal: true

class City < ApplicationRecord
  # iso field follows the ISO3166 standard, nuts_code field follows the NUTS-1 standard.

  # relations
  belongs_to :region
  belongs_to :country
  has_many :units, dependent: :nullify

  # validations
  validates :name, :iso, :nuts_code,
            presence: true, uniqueness: true
  validates_associated :units

  # callbacks
  before_create do
    self.name = name.mb_chars.titlecase
    self.iso = iso.mb_chars.upcase
    self.nuts_code = nuts_code.mb_chars.upcase
  end
end
