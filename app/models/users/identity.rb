# frozen_string_literal: true

class Identity < ApplicationRecord
  # relations
  belongs_to :user

  # validations
  validates :first_name, :last_name,
            presence: true, strict: true

  # callbacks
  before_validation do
    self.first_name = first_name.capitalize_all
    self.last_name = last_name.upcase(:turkic)
    self.mothers_name = mothers_name.capitalize_all
    self.fathers_name = fathers_name.capitalize_all
    self.place_of_birth = place_of_birth.capitalize_all
  end

  # enumerations
  enum gender: %i[female male other]
  enum marital_status: %i[single married divorced unknown]
end
