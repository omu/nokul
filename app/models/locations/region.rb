# frozen_string_literal: true

class Region < ApplicationRecord
  # nuts_code field follows the NUTS-1 standard, since there is no ISO schema for Turkish regions.

  # relations
  belongs_to :country
  has_many :cities, dependent: :nullify
  has_many :districts, through: :cities
  has_many :units, through: :districts

  # validations
  validates :name, :nuts_code,
            presence: true, uniqueness: true
  validates :country, presence: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.nuts_code = nuts_code.mb_chars.upcase
  end
end
