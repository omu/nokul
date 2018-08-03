# frozen_string_literal: true

class Address < ApplicationRecord
  self.inheritance_column = nil

  # relations
  belongs_to :user
  belongs_to :district

  # validations
  validates :type, presence: true, uniqueness: { scope: :user }
  validates :full_address, presence: true
  validates_with AddressValidator, on: :create

  # enums
  enum type: { formal: 1, informal: 2 }

  # delegations
  delegate :id_number, to: :user

  # callbacks
  before_save { self.full_address = full_address.capitalize_all }
end
