# frozen_string_literal: true

class District < ApplicationRecord
  # relations
  belongs_to :city
  has_many :units, dependent: :nullify

  # validations
  validates :name,
            presence: true, uniqueness: { scope: %i[city_id] }
  validates :city,
            presence: true

  # callbacks
  before_save do
    self.name = name.capitalize_all
  end
end
