# frozen_string_literal: true

Xokul.configure do |config|
  config.endpoint = Tenant.configuration.api_host
  config.bearer_token = Tenant.credentials.xokul[:bearer_token]
end
