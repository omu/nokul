# frozen_string_literal: true

class Identity < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :user
  belongs_to :student, optional: true

  # validations
  validates :type, presence: true, inclusion: { in: self.types.keys }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :mothers_name, allow_blank: true, length: { maximum: 255 }
  validates :fathers_name, allow_blank: true, length: { maximum: 255 }
  validates :gender, presence: true, inclusion: { in: self.genders.keys }
  validates :marital_status, allow_blank: true, inclusion: { in: self.marital_statuses.keys }
  validates :place_of_birth, presence: true, length: { maximum: 255 }
  validates :date_of_birth, presence: true
  validates :registered_to, allow_blank: true, length: { maximum: 255 }
  validates :student_id, uniqueness: true, allow_blank: true
  validates_with AddressAndIdentityValidator, on: :create

  # enums
  enum type: { formal: 1, informal: 2 }
  enum gender: { male: 1, female: 2, other: 3 }
  enum marital_status: { single: 1, married: 2, divorced: 3, unknown: 4 }

  # scopes
  scope :user_identity, -> { formal.find_by(student_id: nil) }

  # callbacks
  before_save do
    self.type = 'informal' if type.blank?
    self.first_name = first_name.capitalize_all
    self.last_name = last_name.upcase_tr
    self.mothers_name = mothers_name.capitalize_all if mothers_name
    self.fathers_name = fathers_name.capitalize_all if fathers_name
    self.place_of_birth = place_of_birth.capitalize_all if place_of_birth
  end
end
