class Position < ApplicationRecord
  # validations
  validates :name, :yoksis_id,
            presence: true, strict: true
  validates :name, :yoksis_id,
            uniqueness: true, strict: true
end
