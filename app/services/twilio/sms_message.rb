# frozen_string_literal: true

module Twilio
  class SmsMessage
    def initialize(to, body)
      response = TWILIO_CLIENT.messages.create(
        from: Nokul::Tenant.credentials.twilio[:sender],
        to:   to,
        body: body
      )

      response.sid
    end
  end
end
