# frozen_string_literal: true

class Address < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :user
  belongs_to :district

  # validations
  validates :type, presence: true, uniqueness: { scope: :user }, inclusion: { in: self.types.keys }
  validates :phone_number, allow_blank: true, length: { maximum: 255 }
  validates :full_address, presence: true, length: { maximum: 255 }
  validates_with AddressAndIdentityValidator, on: :create

  # enums
  enum type: { formal: 1, informal: 2 }

  # delegations
  delegate :id_number, to: :user

  # callbacks
  before_save { self.full_address = full_address.capitalize_all }
end
