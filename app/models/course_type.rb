# frozen_string_literal: true

class CourseType < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name code],
    using: { tsearch: { prefix: true } }
  )

  # relations
  has_many :courses, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :min_credit, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
