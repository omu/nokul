# frozen_string_literal: true

if Rails.env.development?
  OpenIDConnect.http_config do |config|
    config.ssl_config.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end
