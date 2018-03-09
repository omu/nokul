class Unit < ApplicationRecord
  # concerns
  include UnitStatus

  # relations
  has_ancestry
  belongs_to :university

  # validations
  validates :name, :yoksis_id, :status,
            presence: true, strict: true
  validates :yoksis_id,
            uniqueness: true, strict: true

  # callbacks
  before_validation do
    self.name = name.mb_chars.titlecase
  end

  # STI helpers
  def self.types
    %w(Faculty Institute VocationalSchool Academy Department ScienceDiscipline ArtDiscipline)
  end

  scope :faculties, -> { where(type: 'Faculty') } 
  scope :institutes, -> { where(type: 'Institute') }
  scope :vocational_schools, -> { where(type: 'VocationalSchool') }
  scope :academies, -> { where(type: 'Academy') }
  scope :departments, -> { where(type: 'Department') }
  scope :science_disciplines, -> { where(type: 'ScienceDiscipline') }
  scope :art_disciplines, -> { where(type: 'ArtDiscipline') }
end
