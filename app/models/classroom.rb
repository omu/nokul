# frozen_string_literal: true

class Classroom < ApplicationRecord
  include PgSearch::Model
  include DynamicSearch

  pg_search_scope(
    :search, against: %i[code meksis_id name], using: { tsearch: { prefix: true } }
  )

  search_keys :place_type_id

  belongs_to :place_type
  belongs_to :building
end
