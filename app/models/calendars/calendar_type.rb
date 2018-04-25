# frozen_string_literal: true

class CalendarType < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
end
