# frozen_string_literal: true

class Unit < ApplicationRecord
  # relations
  has_ancestry
  belongs_to :city
  has_many :responsibles, foreign_key: 'unit_id', class_name: 'Responsibility'

  # reference models
  belongs_to :unit_status
  belongs_to :unit_type
  belongs_to :unit_instruction_language
  belongs_to :unit_instruction_type
  belongs_to :university_type

  # validations
  validates :name, :yoksis_id, :type,
            presence: true
  validates :yoksis_id,
            uniqueness: true
  validates :name,
            uniqueness: { scope: %i[ancestry unit_status_id] }

  # callbacks
  before_validation do
    self.name = name.capitalize_all if name
  end

  # list all unit types
  def self.types
    descendants.map(&:name)
  end

  # scopes
  scope :academies, -> { where(type: 'Academy') }
  scope :art_disciplines, -> { where(type: 'ArtDiscipline') }
  scope :departments, -> { where(type: 'Department') }
  scope :disciplines, -> { where(type: 'Discipline') }
  scope :doctoral_programs, -> { where(type: 'DoctoralProgram') }
  scope :faculties, -> { where(type: 'Faculty') }
  scope :institutes, -> { where(type: 'Institute') }
  scope :interdisciplinary_disciplines, -> { where(type: 'InterdisciplinaryDiscipline') }
  scope :interdisciplinary_doctoral_programs, -> { where(type: 'InterdisciplinaryDoctoralProgram') }
  scope :interdisciplinary_master_programs, -> { where(type: 'InterdisciplinaryMasterProgram') }
  scope :master_programs, -> { where(type: 'MasterProgram') }
  scope :proficiency_in_art_programs, -> { where(type: 'ProficiencyInArtProgram') }
  scope :rectorships, -> { where(type: 'Rectorship') }
  scope :research_centers, -> { where(type: 'ResearchCenter') }
  scope :science_disciplines, -> { where(type: 'ScienceDiscipline') }
  scope :undergraduate_programs, -> { where(type: 'UndergraduateProgram') }
  scope :universities, -> { where(type: 'University') }
  scope :vocational_schools, -> { where(type: 'VocationalSchool') }
end
