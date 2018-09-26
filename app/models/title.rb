# frozen_string_literal: true

class Title < ApplicationRecord
  # relations
  has_many :employees, dependent: :nullify

  # validations
  validates :name, presence: true, uniqueness: { scope: %i[code branch] }
  validates :code, presence: true
  validates :branch, presence: true
end
