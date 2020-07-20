# frozen_string_literal: true

TWILIO_CLIENT = Twilio::REST::Client.new(
  Nokul::Tenant.credentials.dig(:twilio, :account_sid),
  Nokul::Tenant.credentials.dig(:twilio, :auth_token)
)
