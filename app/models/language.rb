# frozen_string_literal: true

class Language < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name iso yoksis_code],
    using: { tsearch: { prefix: true } }
  )

  # validations
  validates :name, presence: true, uniqueness: true
  validates :iso, presence: true, uniqueness: true
  validates :yoksis_code, uniqueness: true, allow_nil: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
    self.iso  = iso.upcase_tr
  end
end
