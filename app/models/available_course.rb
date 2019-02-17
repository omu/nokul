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

  # validations
  before_validation :assign_academic_term, on: :create

  # relations
  belongs_to :academic_term
  belongs_to :coordinator, class_name: 'Employee'
  belongs_to :course
  belongs_to :curriculum
  belongs_to :unit
  has_many :evaluation_types, class_name: 'CourseEvaluationType', dependent: :destroy
  has_many :groups, class_name: 'AvailableCourseGroup', dependent: :destroy

  # validations
  validates :assessments_approved, inclusion: { in: [true, false] }
  validates :course, uniqueness: { scope: %i[academic_term curriculum] }

  # delegates
  delegate :code, :name, :theoric, :practice, :laboratory, :credit, :program_type, to: :course
  delegate :name, to: :curriculum, prefix: true
  delegate :name, to: :unit, prefix: true

  private

  def assign_academic_term
    self.academic_term = AcademicTerm.active.last
  end
end
