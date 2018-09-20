# frozen_string_literal: true

class RegistrationDocument < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :academic_term
  belongs_to :document

  # validations
  validates :unit, uniqueness: { scope: %i[academic_term document] }
end
