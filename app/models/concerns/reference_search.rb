# frozen_string_literal: true

module ReferenceSearch
  extend ActiveSupport::Concern
  include PgSearch::Model

  included do
    # search
    pg_search_scope(
      :search,
      against: %i[name],
      using:   { tsearch: { prefix: true } }
    )
  end
end
