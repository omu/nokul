# frozen_string_literal: true

class RegistrationDocument < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    associated_against: {
      unit: :name,
      document_type: :name
    },
    using: { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :unit
  belongs_to :academic_term
  belongs_to :document_type

  # validations
  validates :unit_id, uniqueness: { scope: %i[academic_term document_type] }
  validates :description, length: { maximum: 65_535 }

  # delegates
  delegate :name, to: :document_type
  delegate :active, to: :document_type
end
