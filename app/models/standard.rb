# frozen_string_literal: true

class Standard < ApplicationRecord
  has_many :snccs

  validates :version, presence: true, length: { maximum: 50 }
  validates :name_tr, presence: true, length: { maximum: 255 }
  validates :name_en, presence: true, length: { maximum: 255 }
end
