# frozen_string_literal: true

class Address < ApplicationRecord
  self.inheritance_column = nil

  # virtual attributes
  attr_accessor :country

  # enums
  enum type: { formal: 1, informal: 2 }

  # relations
  belongs_to :user
  belongs_to :district

  # validations
  validates :type, uniqueness: { scope: :user }, inclusion: { in: types.keys }
  validates :phone_number, length: { maximum: 255 },
                           allow_nil: true,
                           allow_blank: true,
                           telephone_number: { country: proc{ |record| record.country }, types: [:mobile] }
  validates :full_address, presence: true, length: { maximum: 255 }
  validates_with AddressAndIdentityValidator, on: :create

  # callbacks
  before_save { self.full_address = full_address.capitalize_turkish }
end
