# frozen_string_literal: true

class User < ApplicationRecord
  # search
  include PgSearch
  pg_search_scope(
    :search,
    against: %i[id_number email],
    associated_against: { identities: %i[first_name last_name] },
    using: { tsearch: { prefix: true } }
  )

  # authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # relations
  has_many :employees, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :duties, through: :employees
  has_many :units, through: :employees
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties

  # academic studies
  has_many :certifications, dependent: :destroy

  # validations
  validates :email, presence: true, uniqueness: true
  validates :id_number, presence: true, uniqueness: true, numericality: { only_integer: true }, length: { is: 11 }
  validates_with EmailAddress::ActiveRecordValidator, field: :email

  # background jobs
  after_create_commit :build_address_information, if: proc { addresses.formal.empty? }
  after_create_commit :build_identity_information, if: proc { identities.formal.empty? }

  def build_address_information
    KpsAddressCreateJob.perform_later(self)
  end

  def build_identity_information
    KpsIdentityCreateJob.perform_later(self)
  end

  # custom methods
  def accounts
    (students + employees).flatten
  end
end
