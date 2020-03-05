# frozen_string_literal: true

class Standard < ApplicationRecord
  # validations
  validates :version, presence: true, length: { maximum: 50 }
  validates :name_tr, presence: true, uniqueness: { scope: :version }, length: { maximum: 255 }
  validates :name_en, presence: true, uniqueness: { scope: :version }, length: { maximum: 255 }
end
