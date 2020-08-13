# frozen_string_literal: true

class Verification < ApplicationRecord
  validates :mobile_phone, allow_blank:      false,
                           length:           { maximum: 255 },
                           telephone_number: { country: proc { |record| record.country }, types: [:mobile] }

  def country
    TelephoneNumber.parse(mobile_phone).country.country_id
  end
end
