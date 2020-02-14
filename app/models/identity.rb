# frozen_string_literal: true

class Identity < ApplicationRecord
  self.inheritance_column = nil

  # Ldap
  include LDAP::Trigger
  ldap_trigger :user

  # callbacks
  before_save :capitalize_attributes
  after_save :deactivate_identities

  # enums
  enum type: { formal: 1, informal: 2 }
  enum gender: { male: 1, female: 2, other: 3 }
  enum marital_status: { single: 1, married: 2, divorced: 3, unknown: 4 }

  # relations
  belongs_to :user

  # scopes
  scope :active, -> { where(active: true) }

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
  validates :type, inclusion: { in: types.keys }

  # callbacks
  def capitalize_attributes
    assign_attributes(
      fathers_name:   fathers_name&.capitalize_turkish,
      first_name:     first_name.capitalize_turkish,
      last_name:      last_name.upcase(:turkic),
      mothers_name:   mothers_name&.capitalize_turkish,
      place_of_birth: place_of_birth&.capitalize_turkish,
      type:           (type.presence || 'informal')
    )
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def country_of_citizenship
    city.try(:country)
  end

  def city
    City.find_by(name: registered_to.to_s.split('/').last)
  end

  private

  def deactivate_identities
    user.identities.where.not(id: id).update(active: false) if active?
  end
end
