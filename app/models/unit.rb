# frozen_string_literal: true

class Unit < ApplicationRecord
  # type column doesn't reference STI
  self.inheritance_column = nil

  # relations
  has_ancestry
  belongs_to :district
  belongs_to :unit_status
  belongs_to :unit_instruction_type, optional: true
  belongs_to :unit_instruction_language, optional: true
  belongs_to :university_type, optional: true
  has_many :duties, dependent: :destroy
  has_many :employees, through: :duties
  has_many :students, dependent: :nullify

  # validations
  validates :type, presence: true
  validates :yoksis_id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { scope: %i[ancestry unit_status] }
  validates :duration, numericality: { only_integer: true }, allow_blank: true

  # callbacks
  after_commit do
    self.name = name.capitalize_all
  end

  # enums
  enum type: {
    university: 1,
    institute: 2,
    faculty: 3,
    academy: 4,
    vocational_school: 5,
    department: 6,
    discipline: 7,
    art_discipline: 8,
    interdisciplinary_discipline: 9,
    science_discipline: 10,
    interdisciplinary_master_program: 10,
    interdisciplinary_doctoral_program: 12,
    proficiency_in_art_program: 13,
    undergraduate_program: 14,
    master_program: 15,
    doctoral_program: 16,
    rectorship: 17,
    research_center: 18
  }
end
