# frozen_string_literal: true

class Position < ApplicationRecord
  # relations
  belongs_to :duty
  belongs_to :administrative_function

  # validations
  validates :start_date, presence: true
  validates :duty, uniqueness: { scope: %i[administrative_function start_date] }
  validates_with PositionValidator

  # arel tables
  positions = Position.arel_table

  # scopes
  scope :active, -> { where(positions[:end_date].gt(Time.zone.today).or(positions[:end_date].eq(nil))) }

  # custom methods
  def active?
    end_date.nil? || end_date.future?
  end
end
