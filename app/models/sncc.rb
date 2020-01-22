# frozen_string_literal: true

class Sncc < ApplicationRecord
  belongs_to :unit
  belongs_to :standard

  has_many :iccs, dependent: :destroy

  validates :unit_id, presence: true
  validates :code, presence: true, length: { maximum: 10 }
  validates :name_tr, presence: true, length: { maximum: 255 }
  validates :name_en, presence: true, length: { maximum: 255 }
end
