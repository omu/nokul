# frozen_string_literal: true

class Agenda < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[description],
    using: { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :unit
  belongs_to :agenda_type

  # validations
  validates :description, presence: true
  validates :status, presence: true

  # enums
  enum status: { newly: 0, desided: 1, delayed: 2 }
end
