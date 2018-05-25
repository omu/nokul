# frozen_string_literal: true

class AdministrativeFunction < ApplicationRecord
  # relations
  has_many :positions
  has_many :duties, through: :positions

  # validations
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true, numericality: { only_integer: true }

  # callbacks
  after_commit do
    self.name = name.capitalize_all
  end
end
