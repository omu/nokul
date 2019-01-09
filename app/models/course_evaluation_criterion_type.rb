# frozen_string_literal: true

class CourseEvaluationCriterionType < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(:search, against: :name, using: { tsearch: { prefix: true } })

  # validations
  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }
  validates :identifier, presence: true, uniqueness: true, length: { maximum: 255 }

  # callbacks
  before_validation { self.name = name.capitalize_turkish if name }
end
