# frozen_string_literal: true

class Course < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :unit

  # validations
  validates :abrogated_date, presence: true, if: :abrogated?
  validates :code, presence: true, uniqueness: true
  validates :credit, presence: true, numericality: { greater_than: 0 }
  validates :education_type, presence: true
  validates :laboratory, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :language, presence: true
  validates :name, presence: true, uniqueness: { scope: :code }
  validates :practice, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status, presence: true
  validates :theoric, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # callbacks
  before_validation do
    self.name           = name.capitalize_all if name
    self.abrogated_date = (abrogated? ? Time.zone.today : nil) if status_changed?
    self.credit         = calculate_credit
  end

  # enumerations
  enum education_type: { undergraduate: 0, master: 1, doctoral: 2 }
  enum status: { passive: 0, active: 1, abrogated: 2 }

  # scopes
  default_scope -> { order('name DESC') }

  def calculate_credit
    theoric + (practice.to_f / 2)
  end
end
