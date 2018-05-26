# frozen_string_literal: true

class Duty < ApplicationRecord
  # relations
  belongs_to :employee
  belongs_to :unit
  has_many :positions, dependent: :destroy
  has_many :administrative_functions, through: :positions

  # validations
  validates :temporary, presence: true
  validates :start_date, presence: true
  validates :unit_id, uniqueness: { scope: %i[employee] }
  validates_with DutyValidator

  # scopes
  scope :temporary, -> { where(temporary: true) }
  scope :tenure, -> { where(temporary: false) }
  scope :active, -> { where('end_date < ? OR end_date IS NULL', Time.zone.today) }
end
