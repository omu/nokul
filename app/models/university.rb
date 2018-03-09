class University < ApplicationRecord
  # concerns
  include UnitStatus
  include UniversityType

  # relations
  belongs_to :city
  has_many :units
  
  # validations
  validates :name, :short_name, :yoksis_id, :university_type, :status,
            presence: true, strict: true
  validates :name, :short_name, :yoksis_id,
            uniqueness: true, strict: true

  # callbacks
  before_validation do
    self.name = name.mb_chars.titlecase
    self.short_name = name.split(' ').map(&:first).join.mb_chars.upcase
  end

  # delegations
  delegate :faculties, :institutes, :vocational_schools, :academies, to: :units
end
