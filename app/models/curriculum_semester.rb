# frozen_string_literal: true

class CurriculumSemester < ApplicationRecord
  include EnumForTerm

  # relations
  belongs_to :curriculum, counter_cache: :semesters_count, inverse_of: :semesters
  has_many :curriculum_courses, dependent: :destroy
  has_many :curriculum_course_groups, dependent: :destroy
  has_many :courses, through: :curriculum_courses
  has_many :available_courses, through: :curriculum_courses
  has_many :elective_courses, through: :curriculum_course_groups, source: :courses

  # validations
  validates :sequence, numericality: { greater_than: 0 },
                       uniqueness:   { scope: :curriculum_id }
  validates :year, numericality: { greater_than: 0 },
                   uniqueness:   { scope: %i[sequence curriculum_id] }
  validates :term, uniqueness: { scope: %i[year curriculum_id] }

  # scopes
  scope :ordered, -> { order(:sequence) }

  # custom methods
  def total_ects
    curriculum_courses.compulsory.sum(:ects).to_f + curriculum_course_groups.sum(:ects).to_f
  end
end
