# frozen_string_literal: true

class Curriculum < ApplicationRecord
  attr_accessor :number_of_semesters, :type

  # constants
  MAX_NUMBER_OF_SEMESTERS = 12
  MAX_NUMBER_OF_YEARS = 6

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

  # enumerations
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :unit
  has_many :curriculum_programs, dependent: :destroy
  has_many :programs, through: :curriculum_programs,
                      source: :unit
  has_many :semesters, class_name: 'CurriculumSemester',
                       inverse_of: :curriculum,
                       dependent: :destroy
  has_many :courses, through: :semesters
  has_many :curriculum_course_groups, through: :semesters
  has_many :course_groups, through: :curriculum_course_groups
  has_many :available_courses, dependent: :destroy

  # nested models
  accepts_nested_attributes_for :semesters, reject_if: :all_blank, allow_destroy: true

  # validations
  validates :name, presence: true, uniqueness: { scope: :unit_id }, length: { maximum: 255 }
  validates :programs, presence: true
  validates :semesters_count, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: statuses.keys }

  # custom methods
  def build_semesters(number_of_semesters: 0, type: :periodic)
    divisor = (type.to_sym == :periodic ? 2 : 1)
    (1..number_of_semesters.to_i).each do |sequence|
      semesters.build(sequence: sequence, year: (sequence.to_f / divisor).round)
    end
  end
end
