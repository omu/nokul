# frozen_string_literal: true

class Term < ApplicationRecord
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name identifier],
    using: { tsearch: { prefix: true } }
  )

  # validations
  validates :name, presence: true, uniqueness: true
  validates :identifier, presence: true, uniqueness: true

  # callbacks
  before_save { self.name = name.capitalize_all }
end
