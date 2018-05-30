# frozen_string_literal: true

class City < ApplicationRecord
  # iso field follows the ISO3166 standard, nuts_code field follows the NUTS-1 standard.

  # relations
  belongs_to :region
  has_many :districts, dependent: :nullify
  has_many :addresses, through: :districts
  has_many :units, through: :districts

  # validations
  validates :name, presence: true, uniqueness: true
  validates :iso, presence: true, uniqueness: true
  validates :nuts_code, presence: true, uniqueness: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.iso = iso.upcase_tr
    self.nuts_code = nuts_code.upcase_tr
  end
end
