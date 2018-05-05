# frozen_string_literal: true

class Country < ApplicationRecord
  # name, iso and code fields follow the ISO3166 standard.

  # relations
  has_many :cities, dependent: :nullify
  has_many :regions, dependent: :nullify

  # validations
  validates :name, :iso, :code,
            presence: true, uniqueness: true

  # callbacks
  before_save do
    self.name = name.mb_chars.titlecase
    self.iso = iso.mb_chars.upcase
  end
end
