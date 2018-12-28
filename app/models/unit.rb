# frozen_string_literal: true

class Unit < ApplicationRecord
  # search
  include PgSearch
  include DynamicSearch

  pg_search_scope(
    :search,
    against: %i[name yoksis_id detsis_id],
    using: { tsearch: { prefix: true } }
  )

  # dynamic_search
  search_keys :duration, :unit_status_id, :unit_instruction_type_id, :unit_instruction_language_id

  # callbacks
  before_save :cache_ancestry
  before_validation { self.name = name.capitalize_all if name }

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
  has_many :course_groups, dependent: :nullify
  has_many :curriculum_programs, dependent: :destroy
  has_many :curriculums, through: :curriculum_programs
  has_many :managed_curriculums, dependent: :destroy, class_name: 'Curriculum'
  has_many :registration_documents, dependent: :destroy
  has_many :prospective_students, dependent: :destroy
  has_many :available_courses, dependent: :destroy
  has_many :unit_calendars, dependent: :destroy
  has_many :calendars, -> { distinct }, through: :unit_calendars

  # validations
  validates :name, presence: true, uniqueness: { scope: %i[ancestry unit_status] }, length: { maximum: 255 }
  validates :yoksis_id, allow_nil: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 6 }
  validates :detsis_id, allow_nil: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 8 }
  validates :osym_id, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :foet_code, allow_nil: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :duration, allow_nil: true, numericality: { only_integer: true }, inclusion: 1..8

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

  def cache_ancestry
    self.names_depth_cache = path.map(&:name).reverse.join(' / ')
  end

  # custom methods
  def subprograms
    descendants.programs
  end

  def subtree_employees
    Employee.includes(:user, :title).joins(:units, user: :identities)
            .where(units: { id: subtree.active.ids })
  end
end
