# frozen_string_literal: true

class AvailableCourse < ApplicationRecord
  # search
  include DynamicSearch
  include PgSearch

  pg_search_scope(
    :search,
    associated_against: { course: %i[name code] },
    using: { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :unit_id, :curriculum_id, :academic_term_id

  # relations
  belongs_to :academic_term
  belongs_to :curriculum
  belongs_to :course
  belongs_to :unit
  belongs_to :coordinator, class_name: 'Employee', optional: true
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy

  # validations
  validates :course, uniqueness: { scope: %i[academic_term curriculum] }

  # delegates
  delegate :code, :name, :theoric, :practice, :laboratory, :credit, :program_type, to: :course
  delegate :name, to: :curriculum, prefix: true
  delegate :name, to: :unit, prefix: true
end
