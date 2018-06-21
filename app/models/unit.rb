# frozen_string_literal: true

class Unit < ApplicationRecord
  # type column doesn't reference STI
  self.inheritance_column = nil

  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[name yoksis_id],
    using: { tsearch: { prefix: true } }
  )

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
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties

  # validations
  validates :type, presence: true
  validates :yoksis_id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :name, presence: true, uniqueness: { scope: %i[ancestry unit_status] }
  validates :duration, numericality: { only_integer: true }, allow_blank: true

  # callbacks
  before_save { self.name = name.capitalize_all }

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
    interdisciplinary_master_program: 11,
    interdisciplinary_doctoral_program: 12,
    proficiency_in_art_program: 13,
    undergraduate_program: 14,
    master_program: 15,
    doctoral_program: 16,
    rectorship: 17,
    research_center: 18
  }

  # dynamic search scopes
  scope :duration, ->(time) { where(duration: time) }
  scope :unit_status_id, ->(id) { where(unit_status_id: id) }
  scope :unit_instruction_type_id, ->(id) { where(unit_instruction_type_id: id) }
  scope :unit_instruction_language_id, ->(id) { where(unit_instruction_language_id: id) }
end
