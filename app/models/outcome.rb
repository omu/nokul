# frozen_string_literal: true

class Outcome < ApplicationRecord
  # relations
  belongs_to :unit_standard

  # validations
  validates :code, presence: true, uniqueness: { scope: :unit_standard_id }, length: { maximum: 10 }
  validates :name, presence: true, length: { maximum: 255 }

  # delegates
  delegate :unit, to: :unit_standard

  # scopes
  scope :ordered, -> { order(:code) }
end
