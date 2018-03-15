class Unit < ApplicationRecord
  # concerns
  include UnitStatus
  include InstructionType

  # relations
  has_ancestry
  belongs_to :city
  has_many :programs, dependent: :nullify
  has_many :responsibles, foreign_key: 'unit_id', class_name: 'Responsibility'

  # validations
  validates :name, :yoksis_id, :status, :type, :instruction_type,
            presence: true, strict: true
  validates :yoksis_id,
            uniqueness: true, strict: true
  validates :name,
            uniqueness: { scope: %i[ancestry status] }
  validates_associated :programs

  # callbacks
  before_validation do
    self.name = name.capitalize_all
  end

  # STI helpers
  def self.types
    %w[
      University Faculty Institute VocationalSchool Academy Department ScienceDiscipline ArtDiscipline
      InterdisciplinaryDiscipline Discipline Rectorship ResearchCenter
    ]
  end

  scope :universities, -> { where(type: 'University') }
  scope :faculties, -> { where(type: 'Faculty') }
  scope :institutes, -> { where(type: 'Institute') }
  scope :vocational_schools, -> { where(type: 'VocationalSchool') }
  scope :academies, -> { where(type: 'Academy') }
  scope :departments, -> { where(type: 'Department') }
  scope :science_disciplines, -> { where(type: 'ScienceDiscipline') }
  scope :art_disciplines, -> { where(type: 'ArtDiscipline') }
  scope :interdisciplinary_disciplines, -> { where(type: 'InterdisciplinaryDiscipline') }
  scope :disciplines, -> { where(type: 'Discipline') }
  scope :rectorship, -> { where(type: 'Rectorship') }
  scope :research_centers, -> { where(type: 'ResearchCenter') }

  # delegations
  delegate :undergraduate_programs,
           :master_programs,
           :doctoral_programs,
           :interdisciplinary_master_programs,
           :interdisciplinary_doctoral_programs,
           :proficiency_in_art_programs,
           to: :programs
end
