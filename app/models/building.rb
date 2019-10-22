# frozen_string_literal: true

class Building < ApplicationRecord
  include PgSearch::Model
  include DynamicSearch

  pg_search_scope(
    :search, against: %i[meksis_id code name], using: { tsearch: { prefix: true } }
  )

  search_keys :unit_id, :place_type_id

  belongs_to :place_type
  belongs_to :unit

  has_many :classrooms, dependent: :destroy

  scope :actives,  -> { where(active: true)  }
  scope :passives, -> { where(active: false) }
end
