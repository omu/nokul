# frozen_string_literal: true

class PlaceType < ApplicationRecord
  include PgSearch::Model

  pg_search_scope(
    :search, against: %i[name], using: { tsearch: { prefix: true } }
  )

  has_ancestry

  has_one :building, dependent: :destroy
  has_one :classroom, dependent: :destroy

  def number_of_children
    children.count
  end

  def self.non_roots
    all - roots
  end
end
