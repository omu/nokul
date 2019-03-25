# frozen_string_literal: true

class InvalidPhoneNumberError < StandardError
  def message
    I18n.t('errors.invalid_phone_number')
  end
end
