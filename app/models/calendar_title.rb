# frozen_string_literal: true

class CalendarTitle < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name],
    using: { tsearch: { prefix: true } }
  )

  # relations
  has_many :calendar_title_types, foreign_key: :title_id, inverse_of: :title, dependent: :destroy
  has_many :types, through: :calendar_title_types
  has_many :calendar_events, dependent: :destroy

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :identifier, presence: true, uniqueness: true, length: { maximum: 255 }

  # callbacks
  before_save { self.name = name.capitalize_all }
end
