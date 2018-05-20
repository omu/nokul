# frozen_string_literal: true

class Duty < ApplicationRecord
  # relations
  belongs_to :employee
  belongs_to :unit

  # validations
  validates :temporary, presence: true
  validates :start_date, presence: true
  validates :employee, presence: true
  validates :unit, presence: true
  validates :unit_id, uniqueness: { scope: %i[employee] }
end
