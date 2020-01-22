# frozen_string_literal: true

class Icc < ApplicationRecord
  belongs_to :sncc

  has_many :targets, dependent: :delete_all

  validates :unit_id, presence: true
  validates :sncc_id, presence: true
  validates :code, presence: true, length: { maximum: 10 }
  validates :name_tr, presence: true, length: { maximum: 255 }
  validates :name_en, presence: true, length: { maximum: 255 }
end
