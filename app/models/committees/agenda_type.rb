# frozen_string_literal: true

class AgendaType < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: :name,
    using: { tsearch: { prefix: true } }
  )

  # reloations
  has_many :agendas, dependent: :nullify

  # validations
  validates :name, presence: true

  # callbacks
  before_save { self.name = name.capitalize_all }
end
