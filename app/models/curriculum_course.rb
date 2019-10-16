# frozen_string_literal: true

class CurriculumCourse < ApplicationRecord
  self.inheritance_column = :_type_disabled

  # callbacks
  before_validation :assign_type

  # enums
  enum type: { compulsory: 0, elective: 1 }

  # relations
  belongs_to :course
  belongs_to :curriculum_course_group, optional: true
  belongs_to :curriculum_semester
  has_many :available_courses, dependent: :destroy

  # validations
  validates :ects, numericality: { greater_than: 0 }
  validates :type, inclusion: { in: types.keys }
  validates_with CurriculumCourseValidator

  # delegates
  delegate :code, :credit, :course_type, :name, :theoric, :practice, :laboratory, :program_type, to: :course

  # callbacks
  def assign_type
    self.type = curriculum_course_group.nil? ? :compulsory : :elective
  end
end
