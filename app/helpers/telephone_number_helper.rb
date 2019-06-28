# frozen_string_literal: true

module TelephoneNumberHelper
  # phone_parse("+13175082237")
  def phone_parse(phone)
    TelephoneNumber.parse(phone)
  end

  # phone_parse_with_country("3175082237", :us)
  def phone_parse_with_country(phone, country)
    TelephoneNumber.parse(phone, country)
  end
end
