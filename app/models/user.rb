# frozen_string_literal: true

class User < ApplicationRecord
  # devise
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :lockable

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  # relations
  has_one :identity, dependent: :destroy
  has_many :addresses, dependent: :destroy

  # validations
  validates :email, :id_number,
            presence: true, strict: true
  validates :email, :id_number,
            uniqueness: true, strict: true
  validates_associated :identity
  validates_associated :addresses

  # callbacks
  before_save :build_identical_information
  before_save :build_address_information

  # STI helpers
  def self.types
    %w[Academician Employee Student]
  end

  scope :academicians, -> { where(type: 'Academician') }
  scope :employees, -> { where(type: 'Employee') }
  scope :students, -> { where(type: 'Student') }

  private

  # TODO: Will be moved to background jobs.
  def build_identical_information
    # params = Services::Kps::Omu::Kimlik.new.sorgula(id_number)
    # build_identity(params) && true if params
  end

  # TODO: Will be moved to background jobs.
  def build_address_information
    # params = Services::Kps::Omu::Adres.new.sorgula(id_number)
    # addresses.build(params) && true if params
  end
end
