# frozen_string_literal: true

class Language < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name iso],
    using: { tsearch: { prefix: true } }
  )

  # relations
  has_many :courses, dependent: :nullify
  has_many :prospective_students, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: true
  validates :iso, presence: true, uniqueness: true

  # callbacks
  before_save do
    self.name = name.titleize_tr
    self.iso  = iso.upcase_tr
  end
end
