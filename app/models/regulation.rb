# frozen_string_literal: true

class Regulation < ApplicationRecord
  Extensions::Regulation::Loader.call

  # relations
  has_many :regulation_assignments, dependent: :destroy

  RegulationAssignment::RELATABLE_MODELS.each do |model_name|
    has_many model_name.tableize.to_sym,
             through:     :regulation_assignments,
             source:      :assignable,
             source_type: model_name
  end

  # validates
  validates :class_name, presence: true, length: { maximum: 255 }
  validates :effective_date, presence: true

  # scopes
  scope :active, -> { where.not(repealed_at: nil) }

  # delegates
  delegate :display_name, :identifier, to: :klass, allow_nil: true

  alias name display_name

  def klass
    class_name.safe_constantize
  end

  def clauses
    klass&.clauses&.values&.sort || []
  end

  def repealed?
    repealed_at.present?
  end
end
