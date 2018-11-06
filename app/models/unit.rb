# frozen_string_literal: true

class Unit < ApplicationRecord
  # search
  include PgSearch
  include DynamicSearch

  pg_search_scope(
    :search,
    against: %i[name yoksis_id],
    using: { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :duration, :unit_status_id, :unit_instruction_type_id, :unit_instruction_language_id

  # relations
  has_ancestry
  belongs_to :district
  belongs_to :unit_status
  belongs_to :unit_type, optional: true
  belongs_to :unit_instruction_type, optional: true
  belongs_to :unit_instruction_language, optional: true
  belongs_to :university_type, optional: true
  has_many :duties, dependent: :destroy
  has_many :employees, through: :duties
  has_many :students, dependent: :nullify
  has_many :users, through: :employees
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties
  has_many :agendas, dependent: :nullify
  has_many :meetings, dependent: :nullify, class_name: 'CommitteeMeeting'
  has_many :meeting_agendas, through: :meetings
  has_many :decisions, through: :meeting_agendas, class_name: 'CommitteeDecision'
  has_many :courses, dependent: :nullify
  has_many :registration_documents, dependent: :destroy
  has_many :prospective_students, dependent: :destroy

  # validations
  validates :yoksis_id, uniqueness: true, allow_blank: true, numericality: { only_integer: true }, length: { is: 6 }
  validates :detsis_id, uniqueness: true, allow_blank: true, numericality: { only_integer: true }, length: { is: 8 }
  validates :name, presence: true, uniqueness: { scope: %i[ancestry unit_status] }
  validates :duration, numericality: { only_integer: true }, allow_blank: true, inclusion: 1..8

  # callbacks
  before_save { self.name = name.titleize_tr }

  # scopes
  scope :active,            -> { where(unit_status: UnitStatus.active) }
  scope :partially_passive, -> { where(unit_status: UnitStatus.partially_passive) }
  scope :committees,        -> { where(unit_type: UnitType.committee) }
  scope :departments,       -> { where(unit_type: UnitType.department) }
  scope :faculties,         -> { where(unit_type: UnitType.faculty) }
  scope :programs,          -> { where(unit_type: UnitType.program) }
  scope :universities,      -> { where(unit_type: UnitType.university) }
  scope :majors,            -> { where(unit_type: UnitType.major) }
  scope :institutes,        -> { where(unit_type: UnitType.institute) }
  scope :rectorships,       -> { where(unit_type: UnitType.rectorship) }
  scope :without_programs,  -> { where.not(unit_type: UnitType.program) }

  scope :coursable, -> {
    departments
      .or(faculties)
      .or(universities)
      .or(majors)
      .or(institutes)
      .or(rectorships)
  }

  scope :curriculumable, -> { coursable }

  # custom methods
  def subprograms
    descendants.programs
  end
end
