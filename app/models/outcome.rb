# frozen_string_literal: true

class Outcome < ApplicationRecord
  # relations
  belongs_to :accreditation_standard
  belongs_to :macro_outcome, class_name: 'Outcome', foreign_key: :parent_id,
                             inverse_of: :micro_outcomes, optional: true
  has_many :micro_outcomes, class_name: 'Outcome', foreign_key: :parent_id,
                            inverse_of: :macro_outcome, dependent: :destroy
  accepts_nested_attributes_for :micro_outcomes, reject_if: :all_blank, allow_destroy: true

  # validations
  validates :code, presence: true, uniqueness: { scope: :accreditation_standard_id }, length: { maximum: 10 }
  validates :name, presence: true, length: { maximum: 255 }
  validates_with OutcomeValidator

  # scopes
  scope :ordered, -> { order(:code) }
end
