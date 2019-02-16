# frozen_string_literal: true

class Title < ApplicationRecord
  # search
  include ReferenceSearch

  # relations
  has_many :employees, dependent: :nullify

  # validations
  validates :branch, presence: true, length: { maximum: 255 }
  validates :code, presence: true, length: { maximum: 255 }
  validates :name, presence: true, uniqueness: { scope: %i[code branch] }, length: { maximum: 255 }
end
