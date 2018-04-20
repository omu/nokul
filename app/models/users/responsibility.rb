# frozen_string_literal: true

class Responsibility < ApplicationRecord
  # relations
  belongs_to :user
  belongs_to :unit
  belongs_to :position

  # validations
  validates :user_id, :unit_id, :position_id,
            presence: true, strict: true
end
