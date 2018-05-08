# frozen_string_literal: true

class Address < ApplicationRecord
  # relations
  belongs_to :user

  # validations
  validates :city, presence: true
  validates :city_id, presence: true
  validates :district, presence: true
  validates :full_address, presence: true, uniqueness: { scope: %i[city user_id] }

  # callbacks
  before_save do
    self.city = city.capitalize_all
    self.district = district.capitalize_all
    self.neighbourhood = neighbourhood.capitalize_all
    self.full_address = full_address.capitalize_all
  end
end
