# frozen_string_literal: true

class Employee < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :title
  has_many :duties, dependent: :destroy
  has_many :units, through: :duties
  has_many :positions, through: :duties
  has_many :administrative_functions, through: :duties

  # validations
  validates :title_id, uniqueness: { scope: %i[user] }
  validates :active, presence: true
  validates_with EmployeeValidator

  # delegations
  delegate :identities, to: :user

  # scopes
  scope :active, -> { where(active: true) }
  scope :passive, -> { where(active: false) }
end
