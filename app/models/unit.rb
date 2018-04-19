class Unit < ApplicationRecord
  # concerns
  include UnitStatus
  include InstructionType

  # relations
  has_ancestry
  belongs_to :city
  has_many :responsibles, foreign_key: 'unit_id', class_name: 'Responsibility'

  # validations
  validates :name, :yoksis_id, :status, :type, :instruction_type,
            presence: true, strict: true
  validates :yoksis_id,
            uniqueness: true, strict: true
  validates :name,
            uniqueness: { scope: %i[ancestry status] }

  # callbacks
  before_validation do
    self.name = name.capitalize_all
  end

  # STI helpers
  def self.types
    %w[
      University Faculty Institute VocationalSchool Academy Department ScienceDiscipline ArtDiscipline
      InterdisciplinaryDiscipline Discipline Rectorship ResearchCenter UndergraduateProgram MasterProgram
      DoctoralProgram InterdisciplinaryMasterProgram InterdisciplinaryDoctoralProgram ProficiencyInArtProgram
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
  scope :undergraduate_programs, -> { where(type: 'UndergraduateProgram') }
  scope :master_programs, -> { where(type: 'MasterProgram') }
  scope :doctoral_programs, -> { where(type: 'DoctoralProgram') }
  scope :interdisciplinary_master_programs, -> { where(type: 'InterdisciplinaryMasterProgram') }
  scope :interdisciplinary_doctoral_programs, -> { where(type: 'InterdisciplinaryDoctoralProgram') }
  scope :proficiency_in_art_programs, -> { where(type: 'ProficiencyInArtProgram') }
end
