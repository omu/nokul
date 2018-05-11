# frozen_string_literal: true

class User < ApplicationRecord
  # authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # relations
  has_one :identity, dependent: :destroy
  has_many :addresses, dependent: :destroy

  # validations
  validates :email, presence: true, uniqueness: true
  validates :id_number, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates_with EmailAddress::ActiveRecordValidator, field: :email
end
