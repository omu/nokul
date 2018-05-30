# frozen_string_literal: true

class Position < ApplicationRecord
  # relations
  belongs_to :duty
  belongs_to :administrative_function

  # validations
  validates :duty, uniqueness: { scope: %i[administrative_function] }
end
