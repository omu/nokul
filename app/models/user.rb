# frozen_string_literal: true

class User < ApplicationRecord
  # authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # relations
  has_one :employee, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :addresses, dependent: :destroy

  # validations
  validates :email, presence: true, uniqueness: true
  validates :id_number, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 11 }
  validates_with EmailAddress::ActiveRecordValidator, field: :email
  # custom methods
  def accounts
    (students + [employee]).flatten
  end
end
