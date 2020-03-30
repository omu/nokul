# frozen_string_literal: true

class TuitionDebt < ApplicationRecord
  # virtual attributes
  attr_accessor :unit_ids

  # relations
  belongs_to :student
  belongs_to :academic_term
  belongs_to :unit_tuition

  # validations
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 65_535 }
end
