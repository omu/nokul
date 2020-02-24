# frozen_string_literal: true

class Curriculum < ApplicationRecord
  # constants
  MAX_NUMBER_OF_SEMESTERS = 12
  MAX_NUMBER_OF_YEARS = 6

  # search
  include PgSearch::Model
  include DynamicSearch

  pg_search_scope(
    :search,
    against: %i[name],
    using:   { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :unit_id, :status

  # enumerations
  enum status: { passive: 0, active: 1 }

  # relations
  belongs_to :unit
  has_many :available_courses, dependent: :destroy
  has_many :curriculum_programs, dependent: :destroy
  has_many :programs, through: :curriculum_programs,
                      source:  :unit
  has_many :semesters, class_name: 'CurriculumSemester',
                       inverse_of: :curriculum,
                       dependent:  :destroy
  has_many :courses, through: :semesters
  has_many :curriculum_course_groups, through: :semesters
  has_many :course_groups, through: :curriculum_course_groups

  # nested models
  accepts_nested_attributes_for :semesters, reject_if: :all_blank, allow_destroy: true

  # validations
  validates :name, presence: true, uniqueness: { scope: :unit_id }, length: { maximum: 255 }
  validates :programs, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validate :check_semesters_count

  # custom methods
  def build_semesters
    return if semesters_count >= number_of_semesters

    (1..number_of_semesters).each do |sequence|
      semesters.build(sequence: sequence,
                      year:     (sequence.to_f / number_of_semesters_for_one_year).round,
                      term:     %i[spring fall][sequence % 2])
    end
    semesters
  end

  def number_of_semesters
    @number_of_semesters ||= duration.to_i * number_of_semesters_for_one_year
  end

  private

  # delegates
  delegate :semester_type, :duration, to: :program, allow_nil: true

  def program
    @program ||= programs.last
  end

  def number_of_semesters_for_one_year
    semester_type&.to_sym == :periodic ? 2 : 1
  end

  def check_semesters_count
    return if semesters.size == number_of_semesters

    errors.add(:semesters_count, :number_of_semesters_must_be_equal, count: number_of_semesters)
  end
end
