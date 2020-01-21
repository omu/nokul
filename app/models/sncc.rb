# frozen_string_literal: true

class Sncc < ApplicationRecord
  belongs_to :institution

  has_many :icc, dependent: :destroy

  validates :institution_id, presence: true
  validates :code, presence: true, length: { maximum: 10 }
  validates :name_tr, presence: true, length: { maximum: 255 }
  validates :name_en, presence: true, length: { maximum: 255 }
end
