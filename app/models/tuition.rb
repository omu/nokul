# frozen_string_literal: true

class Tuition < ApplicationRecord
  # relations
  belongs_to :academic_term
  has_many :unit_tuitions, dependent: :destroy
  has_many :units, through: :unit_tuitions

  # validations
  validates :fee, numericality: { greater_than_or_equal_to: 0 }
  validates :foreign_student_fee, numericality: { greater_than_or_equal_to: 0 }
end
