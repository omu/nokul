# frozen_string_literal: true

Authy.api_key = Tenant.credentials.authy[:api_secret]
Authy.api_uri = 'https://api.authy.com'
