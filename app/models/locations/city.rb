# frozen_string_literal: true

class City < ApplicationRecord
  # alpha_2_code field follows the ISO3166-2 standard

  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name alpha_2_code],
    using: { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :country
  has_many :districts, dependent: :nullify
  has_many :addresses, through: :districts
  has_many :units, through: :districts

  # validations
  validates :name, presence: true, uniqueness: true
  validates :alpha_2_code, presence: true, uniqueness: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.alpha_2_code = alpha_2_code.upcase_tr
  end
end
