class Unit < ApplicationRecord
  # concerns
  include UnitStatus

  # relations
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
    %w(Faculty Institute VocationalSchool Academy)
  end

  scope :faculties, -> { where(type: 'Faculty') } 
  scope :institutes, -> { where(type: 'Institute') }
  scope :vocational_schools, -> { where(type: 'VocationalSchool') }
  scope :academies, -> { where(type: 'Academy') } 
end
