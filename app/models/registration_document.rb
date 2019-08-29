# frozen_string_literal: true

class RegistrationDocument < ApplicationRecord
  # search
  include PgSearch::Model
  pg_search_scope(
    :search,
    associated_against: {
      unit:          :name,
      document_type: :name
    },
    using:              { tsearch: { prefix: true } }
  )

  # relations
  belongs_to :academic_term
  belongs_to :document_type
  belongs_to :unit

  # validations
  validates :description, length: { maximum: 65_535 }
  validates :unit_id, uniqueness: { scope: %i[academic_term document_type] }

  # delegates
  delegate :name, :active, to: :document_type
end
