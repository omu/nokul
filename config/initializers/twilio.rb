# frozen_string_literal: true

TWILIO_CLIENT = Twilio::REST::Client.new(
  Tenant.credentials.dig(:twilio, :account_sid),
  Tenant.credentials.dig(:twilio, :auth_token)
)
