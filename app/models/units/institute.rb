class Institute < ApplicationRecord
  # concerns
  include UnitStatus

  # relations
  belongs_to :university
  has_many :master_programs
  has_many :doctoral_programs
  has_many :proficiency_in_art_programs
  has_many :interdisciplinary_departments

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
