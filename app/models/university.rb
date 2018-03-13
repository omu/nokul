class University < ApplicationRecord
  # concerns
  include UnitStatus

  # relations
  belongs_to :city
  has_many :units, dependent: :nullify

  # validations
  validates :name, :short_name, :yoksis_id, :university_type, :status,
            presence: true, strict: true
  validates :name, :short_name, :yoksis_id,
            uniqueness: true, strict: true
  validates_associated :units

  # callbacks
  before_validation do
    self.name = name.mb_chars.titlecase
    self.short_name = name.split(' ').map(&:first).join.mb_chars.upcase
  end

  # delegations
  delegate :faculties,
           :institutes,
           :vocational_schools,
           :academies,
           :departments,
           :science_disciplines,
           :art_disciplines,
           :interdisciplinary_disciplines,
           :disciplines,
           :rectorship,
           :research_centers,
           to: :units

  # enumerations
  enum university_type: %w[state foundation]
end
