# frozen_string_literal: true

class District < ApplicationRecord
  # mernis_code field obtained from MERNIS

  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name mernis_code],
    using: { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :city
  has_many :units, dependent: :nullify
  has_many :addresses, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: { scope: %i[city_id] }, length: { maximum: 255 }
  validates :mernis_code, allow_nil: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 4 }
  validates :active, inclusion: { in: [true, false] }

  # callbacks
  before_validation { self.name = name.capitalize_turkish if name }
end
