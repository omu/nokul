# frozen_string_literal: true

# See https://www.twilio.com/verify and authy documentation for details.

module Twilio
  class Verify
    # register user to authy!
    def register_user(email, phone, country_code)
      authy = Authy::API.register_user(
        email: email,
        cellphone: phone,
        country_code: country_code
      )

      if authy.ok?
        # store authy_id in database
        user.authy_id = authy.id
      else
        authy.errors
      end
    end

    # verify authy token
    def verify_token(user, token)
      response = Authy::API.verify(
        id: user.authy_id,
        token: token
      )

      response.ok? ? 'ok' : 'invalid'
    end

    # request authy code as SMS
    def request_sms(user)
      response = Authy::API.request_sms(
        id: user.authy_id,
        locale: user.preferred_language || 'tr'
      )

      response.ok? ? 'ok' : response.errors
    end

    # request QR code for Google Authenticator etc.
    def request_qr_code(user)
      response = Authy::API.request_qr_code(
        id: user.authy_id,
        qr_size: 500,
        label: Tenant.configuration.name
      )

      if response.ok?
        response.qr_code # link of the QR image
      else
        response.errors
      end
    end

    def send_phone_verification_code(phone_number, locale = 'tr')
      response = Authy::PhoneVerification.start(
        via: 'sms',
        country_code: parse_phone_number(phone_number)[:country_code],
        phone_number: parse_phone_number(phone_number)[:normalized_number],
        locale: locale
      )

      'ok' if response.ok?
    end

    def check_verification_code(phone_number, verification_code)
      response = Authy::PhoneVerification.check(
        verification_code: verification_code,
        country_code: parse_phone_number(phone_number)[:country_code],
        phone_number: parse_phone_number(phone_number)[:normalized_number]
      )

      'ok' if response.ok?
    end

    private

    def parse_phone_number(phone_number)
      parsed_number = TelephoneNumber.parse(phone_number)

      {
        country_code: parsed_number.country.country_code,
        normalized_number: parsed_number.normalized_number
      }
    end
  end
end
