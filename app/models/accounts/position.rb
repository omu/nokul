# frozen_string_literal: true

class Position < ApplicationRecord
  # relations
  belongs_to :duty
  belongs_to :administrative_function

  # validations
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :duty, uniqueness: { scope: %i[administrative_function] }
end
