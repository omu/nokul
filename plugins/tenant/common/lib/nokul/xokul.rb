# frozen_string_literal: true

require 'nokul/support/rest_client'

module Nokul
  # Xokul
  module Xokul
    def self.request(path, **params)
      base_url     = Tenant.configuration.api_host
      bearer_token = Tenant.credentials.dig(:xokul, :bearer_token)
      options      = {
        headers:     { 'Authorization' => "Bearer #{bearer_token}" },
        use_ssl:     true,
        verify_mode: OpenSSL::SSL::VERIFY_PEER,
        payload: params.to_json
      }.freeze

      resp = Support::RestClient.get(
        URI.join(base_url, path).to_s, **options
      )

      resp.error!
      resp
    rescue Support::RestClient::HTTPError
      nil
    end
  end
end
