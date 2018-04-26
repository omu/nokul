# frozen_string_literal: true

class CalendarTitle < ApplicationRecord
  # validations
  validates :name, presence: true, uniqueness: true
end
