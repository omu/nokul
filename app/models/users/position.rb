class Position < ApplicationRecord
  # relations
  has_many :responsibilities
  has_many :users, through: :responsibilities

  # validations
  validates :name, :yoksis_id,
            presence: true, strict: true
  validates :name, :yoksis_id,
            uniqueness: true, strict: true

  # callbacks
  before_validation do
    self.name = name.capitalize_all
  end

  # delegations
  delegate :academicians, :employees, to: :users
end
