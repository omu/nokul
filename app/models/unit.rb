class Unit < ApplicationRecord
  # concerns
  include UnitStatus

  # relations
  has_ancestry
  belongs_to :university
  has_many :programs, dependent: :nullify

  # validations
  validates :name, :yoksis_id, :status, :type,
            presence: true, strict: true
  validates :yoksis_id,
            uniqueness: true, strict: true
  validates :name,
            uniqueness: { scope: %i[ancestry status] }
  validates_associated :programs

  # callbacks
  before_validation do
    self.name = name.mb_chars.titlecase
  end

  # STI helpers
  def self.types
    %w[
      Faculty Institute VocationalSchool Academy Department ScienceDiscipline ArtDiscipline
      InterdisciplinaryDiscipline Discipline Rectorship ResearchCenter
    ]
  end

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
