# frozen_string_literal: true

class Country < ApplicationRecord
  # alpha_2_code, alpha_3_code and and numeric code fields follow the ISO3166-1 standard.
  # mernis_code obtained from YOKSIS

  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name alpha_2_code],
    using: { tsearch: { prefix: true } }
  )

  # relations
  has_many :cities, dependent: :destroy
  has_many :districts, through: :cities
  has_many :addresses, through: :districts
  has_many :units, through: :districts

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :alpha_2_code, presence: true, uniqueness: true, length: { is: 2 }
  validates :alpha_3_code, presence: true, uniqueness: true, length: { is: 3 }
  validates :numeric_code, presence: true, uniqueness: true, length: { is: 3 },
                           numericality: { only_integer: true, greater_than: 0 }
  validates :mernis_code, allow_nil: true, uniqueness: true, length: { is: 4 },
                          numericality: { only_integer: true, greater_than: 0 }
  validates :yoksis_code, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.alpha_2_code = alpha_2_code.upcase(:turkic)
    self.alpha_3_code = alpha_3_code.upcase(:turkic)
  end
end
