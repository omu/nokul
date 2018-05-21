# frozen_string_literal: true

class User < ApplicationRecord
  # authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # relations
  has_one :employee, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :duties, through: :employee
  has_many :units, through: :employee

  # validations
  validates :email, presence: true, uniqueness: true
  validates :id_number, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 11 }
  validates_with EmailAddress::ActiveRecordValidator, field: :email

  # background jobs
  after_commit :build_address_information, on: :create, if: proc { addresses.formal.empty? }
  after_commit :build_identity_information, on: :create, if: proc { identities.formal.empty? }

  def build_address_information
    KpsAddressCreateJob.perform_later(self)
  end

  def build_identity_information
    KpsIdentityCreateJob.perform_later(self)
  end

  # custom methods
  def accounts
    (students + [employee]).flatten
  end
end
