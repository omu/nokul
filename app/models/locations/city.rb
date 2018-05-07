# frozen_string_literal: true

class City < ApplicationRecord
  # iso field follows the ISO3166 standard, nuts_code field follows the NUTS-1 standard.

  # relations
  belongs_to :region
  has_many :districts, dependent: :nullify
  has_many :units, through: :districts

  # validations
  validates :name, :iso, :nuts_code,
            presence: true, uniqueness: true
  validates :region,
            presence: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.iso = iso.upcase_tr
    self.nuts_code = nuts_code.upcase_tr
  end
end
