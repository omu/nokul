# frozen_string_literal: true

class Address < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :district

  # validations
  validates :name, presence: true
  validates :full_address, presence: true
  validates_with AddressValidator

  # enums
  enum name: { formal: 1, home: 2, work: 3, other: 4 }

  # delegations
  delegate :id_number, to: :user

  # callbacks
  before_save { self.full_address = full_address.capitalize_all }
end
