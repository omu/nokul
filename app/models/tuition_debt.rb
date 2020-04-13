# frozen_string_literal: true

class TuitionDebt < ApplicationRecord
  self.inheritance_column = nil

  # virtual attributes
  attr_accessor :unit_ids, :unit_id

  # search
  include DynamicSearch

  # dynamic_search
  search_keys :academic_term_id, :student_id

  # enums
  enum type: { personal: 1, bulk: 2 }

  # relations
  belongs_to :student
  belongs_to :academic_term
  belongs_to :unit_tuition, optional: true
  has_one :unit, through: :unit_tuition

  # validations
  validates :academic_term_id, uniqueness: { scope: :student_id }
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 65_535 }
  validates :due_date, presence: true
  validates :paid, inclusion: { in: [true, false] }
  validates :type, inclusion: { in: types.keys }
end
