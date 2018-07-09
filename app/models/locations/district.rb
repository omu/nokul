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
  validates :name, presence: true, uniqueness: { scope: %i[city_id] }
  validates :city, presence: true
  validates :mernis_code, uniqueness: true, numericality: { only_integer: true }, allow_blank: true

  # callbacks
  before_save { self.name = name.capitalize_all }
end
