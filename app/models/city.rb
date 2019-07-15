# frozen_string_literal: true

class City < ApplicationRecord
  # search
  include PgSearch::Model
  pg_search_scope(
    :search,
    against: %i[name alpha_2_code],
    using:   { tsearch: { prefix: true } }
  )

  # callbacks
  before_validation :capitalize_attributes

  # relations
  belongs_to :country
  has_many :districts, dependent: :destroy
  has_many :addresses, through: :districts
  has_many :units, through: :districts

  # validations
  validates :alpha_2_code, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :latitude, numericality: true
  validates :longitude, numericality: true
  validates :name, presence: true, uniqueness: { scope: %i[country_id] }, length: { maximum: 255 }

  # callbacks
  def capitalize_attributes
    self.alpha_2_code = alpha_2_code.upcase(:turkic) if alpha_2_code
    self.name = name.capitalize_turkish if name
  end
end
