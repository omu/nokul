# frozen_string_literal: true

class Identity < ApplicationRecord
  self.inheritance_column = nil

  # Ldap
  include LDAP::Trigger
  ldap_trigger :user

  # callbacks
  before_save :capitalize_attributes

  # enums
  enum type: { formal: 1, informal: 2 }
  enum gender: { male: 1, female: 2, other: 3 }
  enum marital_status: { single: 1, married: 2, divorced: 3, unknown: 4 }

  # relations
  belongs_to :student, optional: true
  belongs_to :user

  # validations
  validates :date_of_birth, presence: true
  validates :fathers_name, length: { maximum: 255 }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :gender, inclusion: { in: genders.keys }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :marital_status, allow_nil: true, inclusion: { in: marital_statuses.keys }
  validates :mothers_name, length: { maximum: 255 }
  validates :place_of_birth, presence: true, length: { maximum: 255 }
  validates :registered_to, length: { maximum: 255 }
  validates :student_id, uniqueness: true, allow_nil: true
  validates :type, inclusion: { in: types.keys }
  validates_with AddressAndIdentityValidator, on: :create

  # scopes
  scope :student_identity, -> { formal.where.not(student_id: nil).first }
  scope :user_identity, -> { formal.find_by(student_id: nil) }

  # callbacks
  # rubocop:disable Metrics/AbcSize
  def capitalize_attributes
    self.fathers_name = fathers_name.capitalize_turkish if fathers_name
    self.first_name = first_name.capitalize_turkish
    self.last_name = last_name.upcase(:turkic)
    self.mothers_name = mothers_name.capitalize_turkish if mothers_name
    self.place_of_birth = place_of_birth.capitalize_turkish if place_of_birth
    self.type = 'informal' if type.blank?
  end
  # rubocop:enable Metrics/AbcSize

  def full_name
    "#{first_name} #{last_name}"
  end

  def country_of_citizenship
    city.try(:country)
  end

  def city
    City.find_by(name: registered_to.to_s.split('/').last)
  end
end
