# frozen_string_literal: true

class SdpCode < ApplicationRecord
  include PgSearch::Model
  include DynamicSearch

  pg_search_scope(
    :search, against: %i[main first second third name], using: { tsearch: { prefix: true } }
  )

  search_keys :main, :first, :second, :third, :name

  # rubocop:disable Style/FormatStringToken
  def to_s
    tmpl = '%03<main>d.%02<first>d.%02<second>d.%02<third>d'
    format(tmpl, main: main, first: first, second: second, third: third)
  end
  # rubocop:enable Style/FormatStringToken
end
