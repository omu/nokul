# frozen_string_literal: true

class Term < ApplicationRecord
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name identifier],
    using: { tsearch: { prefix: true } }
  )

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :identifier, presence: true, uniqueness: true, length: { maximum: 255 }

  # callbacks
  before_validation { self.name = name.capitalize_all if name }
end
