# frozen_string_literal: true

NEXMO_CLIENT = Nexmo::Client.new(
  api_key:    Tenant.credentials.dig(:nexmo, :api_key),
  api_secret: Tenant.credentials.dig(:nexmo, :api_secret)
)
