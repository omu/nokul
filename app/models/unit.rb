# frozen_string_literal: true

class Unit < ApplicationRecord
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
