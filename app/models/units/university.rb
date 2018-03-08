class University < ApplicationRecord
  # concerns
  include UnitStatus
  include UniversityType

  # relations
  belongs_to :city
  has_many :faculties, dependent: :destroy
  has_many :institutes, dependent: :destroy
  has_many :vocational_schools, dependent: :destroy
  has_many :academies, dependent: :destroy
  has_many :departments, dependent: :destroy

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
end
