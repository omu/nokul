# frozen_string_literal: true

class LearningOutcome < ApplicationRecord
  # relations
  belongs_to :accreditation_standard
  belongs_to :macro, class_name: 'LearningOutcome', foreign_key: :parent_id,
                     inverse_of: :micros, optional: true
  has_many :micros, class_name: 'LearningOutcome', foreign_key: :parent_id,
                    inverse_of: :macro, dependent: :destroy
  accepts_nested_attributes_for :micros, reject_if: :all_blank, allow_destroy: true

  # validations
  validates :code, presence: true, uniqueness: { scope: :accreditation_standard_id }, length: { maximum: 10 }
  validates :name, presence: true, length: { maximum: 255 }
  validates_with LearningOutcomeValidator

  # scopes
  scope :ordered, -> { order(:code) }
end
