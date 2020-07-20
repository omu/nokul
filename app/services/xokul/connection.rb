# frozen_string_literal: true

module Xokul
  module Connection
    BASE_URL     = Nokul::Tenant.configuration.api_host
    BEARER_TOKEN = Nokul::Tenant.credentials.dig(:xokul, :bearer_token)
    OPTIONS      = {
      headers:     { 'Authorization' => "Bearer #{BEARER_TOKEN}" },
      use_ssl:     true,
      verify_mode: OpenSSL::SSL::VERIFY_PEER
    }.freeze

    private_constant :BASE_URL, :BEARER_TOKEN, :OPTIONS

    def self.request(path, params: {}, **options)
      resp = Nokul::Support::RestClient.get(
        URI.join(BASE_URL, path).to_s, payload: params.to_json, **OPTIONS.merge(options)
      )

      resp.error!
      resp.decode
    rescue Nokul::Support::RestClient::HTTPError
      nil
    end
  end

  private_constant :Connection
end
