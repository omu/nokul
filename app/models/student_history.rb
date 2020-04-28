# frozen_string_literal: true

class StudentHistory < ApplicationRecord
  # relations
  belongs_to :student
  belongs_to :entrance_type, class_name: 'StudentEntranceType'
  belongs_to :graduation_term, class_name: 'AcademicTerm'
  belongs_to :registration_term, class_name: 'AcademicTerm'

  # validations
  validates :other_studentship, inclusion: { in: [true, false] }
  validates :preparatory_class, numericality: { inclusion: 0..2 }
end
