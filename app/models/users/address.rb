# frozen_string_literal: true

class Address < ApplicationRecord
  # relations
  belongs_to :user

  # validations
  validates :city, :city_id, :district, :full_address,
            presence: true, strict: true
  validates :full_address,
            uniqueness: { scope: %i[city user_id] }

  # callbacks
  before_validation do
    self.city = city.capitalize_all
    self.district = district.capitalize_all
    self.neighbourhood = neighbourhood.capitalize_all
    self.full_address = full_address.capitalize_all
  end
end
