# frozen_string_literal: true

class Identity < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :student, optional: true

  # validations
  validates :name, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true
  validates :place_of_birth, presence: true
  validates :date_of_birth, presence: true
  validates :name, presence: true, uniqueness: { scope: %i[user student] }
  validates_with IdentityValidator

  # enums
  enum name: { formal: 1, informal: 2 }
  enum gender: { male: 1, female: 2, other: 3 }
  enum marital_status: { single: 1, married: 2, divorced: 3, unknown: 4 }

  # callbacks
  before_save do
    self.first_name = first_name.capitalize_all
    self.last_name = last_name.upcase_tr
    self.mothers_name = mothers_name.capitalize_all
    self.fathers_name = fathers_name.capitalize_all
    self.place_of_birth = place_of_birth.capitalize_all
  end
end
