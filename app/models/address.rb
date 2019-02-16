# frozen_string_literal: true

class Address < ApplicationRecord
  self.inheritance_column = nil

  # enums
  enum type: { formal: 1, informal: 2 }

  # relations
  belongs_to :district
  belongs_to :user

  # validations
  validates :full_address, presence: true, length: { maximum: 255 }
  validates :phone_number, length: { maximum: 255 }
  validates :type, uniqueness: { scope: :user }, inclusion: { in: types.keys }
  validates_with AddressAndIdentityValidator, on: :create

  # callbacks
  before_save { self.full_address = full_address.capitalize_turkish }
end
