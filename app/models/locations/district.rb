# frozen_string_literal: true

class District < ApplicationRecord
  # relations
  belongs_to :city

  # validations
  validates :name, :city,
            presence: true
  validates :name,
            uniqueness: { scope: %i[city_id] }

  # callbacks
  before_save do
    self.name = name.mb_chars.titlecase
  end
end
