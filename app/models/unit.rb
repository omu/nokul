# frozen_string_literal: true

class Unit < ApplicationRecord
  # concerns
  include UnitStatus
  include InstructionType

  # relations
  has_ancestry
  belongs_to :city
  has_many :responsibles, foreign_key: 'unit_id', class_name: 'Responsibility'

  # validations
  validates :name, :yoksis_id, :status, :type, :instruction_type,
            presence: true, strict: true
  validates :yoksis_id,
            uniqueness: true, strict: true
  validates :name,
            uniqueness: { scope: %i[ancestry status] }

  # callbacks
  before_validation do
    self.name = name.capitalize_all
  end

  # STI helpers
  def self.types
    descendants.map(&:name)
  end

  # Dynamically generate scopes for STI-related models
  def self.generate_scopes
    types.each do |type|
      scope type.tableize.to_sym, -> { where(type: type) }
    end
  end
end
