# frozen_string_literal: true

class TuitionDebt < ApplicationRecord
  self.inheritance_column = nil

  # virtual attributes
  attr_accessor :unit_ids, :unit_id

  # enums
  enum type: { personal: 1, bulk: 2 }

  # relations
  belongs_to :student
  belongs_to :academic_term
  belongs_to :unit_tuition, optional: true

  # validations
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 65_535 }
  validates :paid, inclusion: { in: [true, false] }
  validates :type, inclusion: { in: types.keys }
end
