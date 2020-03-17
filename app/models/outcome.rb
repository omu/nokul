# frozen_string_literal: true

class Outcome < ApplicationRecord
  # relations
  belongs_to :unit_standard
  belongs_to :macro_outcome, class_name: 'Outcome', foreign_key: :parent_id,
                             inverse_of: :micro_outcomes, optional: true
  has_many :micro_outcomes, class_name: 'Outcome', foreign_key: :parent_id,
                            inverse_of: :macro_outcome, dependent: :destroy

  # validations
  validates :code, presence: true, uniqueness: { scope: :unit_standard_id }, length: { maximum: 10 }
  validates :name, presence: true, length: { maximum: 255 }

  # delegates
  delegate :unit, to: :unit_standard

  # scopes
  scope :ordered, -> { order(:code) }
end
