# frozen_string_literal: true

class CalendarType < ApplicationRecord
  # relations
  has_many :calendar_title_types, foreign_key: :type_id, dependent: :destroy
  has_many :titles, through: :calendar_title_types

  # validations
  validates :name, presence: true, uniqueness: true
end
