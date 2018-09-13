# frozen_string_literal: true

class Agenda < ApplicationRecord
  # relations
  belongs_to :unit
  belongs_to :agenda_type

  # validations
  validates :description, presence: true
  validates :status, presence: true

  # enums
  enum status: { newly: 0, settle: 1, delay: 2 }
end
