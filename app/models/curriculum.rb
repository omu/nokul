# frozen_string_literal: true

class Curriculum < ApplicationRecord
  # search
  include PgSearch
  include DynamicSearch

  pg_search_scope(
    :search,
    against: %i[name],
    using: { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :unit_id, :status

  # relations
  belongs_to :unit
  has_many :unit_curriculums, dependent: :destroy
  has_many :programs, through: :unit_curriculums, source: :unit
  has_many :semesters, class_name: 'CurriculumSemester',
                       inverse_of: :curriculum, dependent: :destroy
  has_many :courses, through: :semesters
  has_many :available_courses, dependent: :destroy

  # nested models
  accepts_nested_attributes_for :semesters, reject_if: :all_blank, allow_destroy: true

  # validations
  validates :name, presence: true, uniqueness: { scope: :unit_id }
  validates :semesters_count, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true

  # enumerations
  enum status: { passive: 0, active: 1 }
end
