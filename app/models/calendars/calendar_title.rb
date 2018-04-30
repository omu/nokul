# frozen_string_literal: true

class CalendarTitle < ApplicationRecord
  # relations
  has_many :calendar_title_types, foreign_key: :title_id, dependent: :destroy
  has_many :types, through: :calendar_title_types

  # validations
  validates :name, presence: true, uniqueness: true
end
