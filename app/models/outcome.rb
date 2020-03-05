# frozen_string_literal: true

class Outcome < ApplicationRecord
  # relations
  belongs_to :unit

  # validations
  validates :code, presence: true, uniqueness: { scope: :unit_id }, length: { maximum: 10 }
  validates :name_tr, presence: true, length: { maximum: 255 }
  validates :name_en, presence: true, length: { maximum: 255 }
end
