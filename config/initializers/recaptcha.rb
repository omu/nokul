# frozen_string_literal: true

Recaptcha.configure do |config|
  config.site_key   = Nokul::Tenant.credentials.dig(:recaptcha, :site_key)
  config.secret_key = Nokul::Tenant.credentials.dig(:recaptcha, :secret_key)
end
