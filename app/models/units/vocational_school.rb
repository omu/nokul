class VocationalSchool < ApplicationRecord
  # concerns
  include UnitStatus

  # relations
  belongs_to :university
  has_many :departments, as: :unit
  has_many :undergraduate_programs, as: :program

  # validations
  validates :name, :yoksis_id, :status,
            presence: true, strict: true
  validates :yoksis_id,
            uniqueness: true, strict: true
  validates_associated :university

  # callbacks
  before_validation do
    self.name = name.mb_chars.titlecase
  end
end
