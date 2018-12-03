# frozen_string_literal: true

class CurriculumSemester < ApplicationRecord
  # relations
  has_many :curriculum_courses, dependent: :destroy
  has_many :curriculum_course_groups, dependent: :destroy
  has_many :courses, through: :curriculum_courses
  belongs_to :curriculum, counter_cache: :semesters_count, inverse_of: :semesters

  # validations
  validates :sequence, numericality: { greater_than: 0 },
                       uniqueness: { scope: :curriculum_id }
  validates :year, numericality: { greater_than: 0 },
                   uniqueness: { scope: %i[sequence curriculum_id] }

  # delegates
  delegate :compulsory, :elective, to: :curriculum_courses

  # custom methods
  def total_ects
    compulsory.sum(:ects).to_f + curriculum_course_groups.sum(:ects).to_f
  end
end
