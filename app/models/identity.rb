# frozen_string_literal: true

class Identity < ApplicationRecord
  self.inheritance_column = nil

  # enums
  enum type: { formal: 1, informal: 2 }
  enum gender: { male: 1, female: 2, other: 3 }
  enum marital_status: { single: 1, married: 2, divorced: 3, unknown: 4 }

  # relations
  belongs_to :user
  belongs_to :student, optional: true

  # validations
  validates :type, inclusion: { in: types.keys }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :mothers_name, length: { maximum: 255 }
  validates :fathers_name, length: { maximum: 255 }
  validates :gender, inclusion: { in: genders.keys }
  validates :marital_status, allow_nil: true, inclusion: { in: marital_statuses.keys }
  validates :place_of_birth, presence: true, length: { maximum: 255 }
  validates :date_of_birth, presence: true
  validates :registered_to, length: { maximum: 255 }
  validates :student_id, uniqueness: true, allow_nil: true
  validates_with AddressAndIdentityValidator, on: :create

  # scopes
  scope :user_identity, -> { formal.find_by(student_id: nil) }

  # callbacks
  before_save do
    self.type = 'informal' if type.blank?
    self.first_name = first_name.capitalize_turkish
    self.last_name = last_name.upcase(:turkic)
    self.mothers_name = mothers_name.capitalize_turkish if mothers_name
    self.fathers_name = fathers_name.capitalize_turkish if fathers_name
    self.place_of_birth = place_of_birth.capitalize_turkish if place_of_birth
  end
end
